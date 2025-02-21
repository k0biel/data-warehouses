import pandas as pd
from faker import Faker
import random
from datetime import datetime, timedelta

fake = Faker()

start_date_t1 = datetime(2000, 1, 1)
end_date_t1 = datetime(2004, 12, 31)  # Okres dla T1
start_date_t2 = datetime(2004, 1, 1)
end_date_t2 = datetime(2006, 12, 31)  # Okres dla T2


def random_date(start, end):
    return start + timedelta(days=random.randint(0, (end - start).days))


def generate_suppliers(n, start_id=0):
    suppliers = []
    for i in range(n):
        suppliers.append({
            "SupplierID": f"SP{i + start_id:04d}",
            "SupplierName": fake.company()
        })
    return pd.DataFrame(suppliers)


def generate_materials(n, suppliers_df, start_id=0):
    materials = []
    for i in range(n):
        materials.append({
            "MaterialID": f"MT{i + start_id:04d}",
            "MaterialName": fake.word(),
            "Unit": random.choice(['kg', 'm', 'm2', 'm3', 'l']),
            "UnitPrice": round(random.uniform(1, 500), 2),
            "SupplierID": random.choice(suppliers_df['SupplierID'])
        })
    return pd.DataFrame(materials)


def generate_projects(n, start_id=0):
    projects = []
    for i in range(n):
        projects.append({
            "ProjectID": f"PJ{i + start_id:04d}",
            "ProjectName": fake.company(),
            "Location": fake.city(),
            "StartDate": random_date(start_date_t1, end_date_t2),
            "ExpectedEndDate": random_date(start_date_t1, end_date_t2 + timedelta(days=365)),
            "ActualEndDate": None,
            "ProjectManagerPesel": fake.unique.bothify(text="###########")
        })
    return pd.DataFrame(projects)


def generate_orders(n, suppliers_df, start_id=0, start_date=start_date_t1, end_date=end_date_t1, cost_decrease_rate=0.98):
    orders = []
    years = (end_date - start_date).days // 365
    for i in range(n):
        order_date = random_date(start_date, end_date)

        years_elapsed = (order_date - start_date).days // 365

        supplier_pool = suppliers_df.head(int(len(suppliers_df) * (1 - 0.1 * years_elapsed)))

        unit_price = round(random.uniform(10, 300) * (cost_decrease_rate ** years_elapsed), 2)
        expected_delivery = order_date + timedelta(days=random.randint(1, 30))
        delivery_date = expected_delivery + timedelta(days=random.randint(0, 15)) if random.random() < 0.7 else None

        orders.append({
            "OrderID": f"OD{i + start_id:06d}",
            "OrderDate": order_date,
            "ExpectedDeliveryDate": expected_delivery,
            "DeliveryDate": delivery_date,
            "OrderCost": unit_price * random.randint(10, 100),
            "WarehouseID": f"WH{i % 1000:04d}",
            "DeliveryStatus": random.choice(['Excellent', 'Average', 'Poor'])
        })
    return pd.DataFrame(orders)


def generate_project_materials(n, projects_df, materials_df, orders_df, start_id=0):
    project_materials = []
    order_ids = orders_df['OrderID'].tolist()  # Lista wszystkich OrderID do wyboru

    for i in range(n):
        project_materials.append({
            "ProjectMaterialID": f"PM{i + start_id:06d}",
            "ProjectID": random.choice(projects_df['ProjectID']),
            "MaterialID": random.choice(materials_df['MaterialID']),
            "Quantity": random.randint(1, 1000),
            "OrderID": random.choice(order_ids)
        })
    return pd.DataFrame(project_materials)


n_suppliers_t1 = 500
n_suppliers_t2 = 100
n_materials_t1 = 2000
n_materials_t2 = 500
n_projects_t1 = 1000
n_projects_t2 = 200
n_orders_t1 = 700000
n_orders_t2 = 300000
n_project_materials_t1 = 50000
n_project_materials_t2 = 50000

suppliers_df_t1 = generate_suppliers(n_suppliers_t1)
materials_df_t1 = generate_materials(n_materials_t1, suppliers_df_t1)
projects_df_t1 = generate_projects(n_projects_t1)
orders_df_t1 = generate_orders(n_orders_t1, suppliers_df_t1)
project_materials_df_t1 = generate_project_materials(n_project_materials_t1, projects_df_t1, materials_df_t1,
                                                     orders_df_t1)

suppliers_df_t2 = generate_suppliers(n_suppliers_t2, start_id=n_suppliers_t1)
materials_df_t2 = generate_materials(n_materials_t2, pd.concat([suppliers_df_t1, suppliers_df_t2], ignore_index=True),
                                     start_id=n_materials_t1)
projects_df_t2 = generate_projects(n_projects_t2, start_id=n_projects_t1)
orders_df_t2 = generate_orders(n_orders_t2, pd.concat([suppliers_df_t1, suppliers_df_t2], ignore_index=True),
                               start_id=n_orders_t1, start_date=start_date_t2, end_date=end_date_t2)
project_materials_df_t2 = generate_project_materials(n_project_materials_t2,
                                                     pd.concat([projects_df_t1, projects_df_t2], ignore_index=True),
                                                     pd.concat([materials_df_t1, materials_df_t2], ignore_index=True),
                                                     pd.concat([orders_df_t1, orders_df_t2], ignore_index=True),
                                                     start_id=n_project_materials_t1)

suppliers_df_t1.to_csv("material-orderding-system/suppliers_t1.csv", sep=';', index=False)
materials_df_t1.to_csv("material-orderding-system/materials_t1.csv", sep=';', index=False)
projects_df_t1.to_csv("material-orderding-system/projects_t1.csv", sep=';', index=False)
orders_df_t1.to_csv("material-orderding-system/orders_t1.csv", sep=';', index=False)
project_materials_df_t1.to_csv("material-orderding-system/project_materials_t1.csv", sep=';', index=False)

suppliers_df_t2.to_csv("material-orderding-system/suppliers_t2.csv", sep=';', index=False)
materials_df_t2.to_csv("material-orderding-system/materials_t2.csv", sep=';', index=False)
projects_df_t2.to_csv("material-orderding-system/projects_t2.csv", sep=';', index=False)
orders_df_t2.to_csv("material-orderding-system/orders_t2.csv", sep=';', index=False)
project_materials_df_t2.to_csv("material-orderding-system/project_materials_t2.csv", sep=';', index=False)

