import pandas as pd
from faker import Faker
import random
from datetime import datetime, timedelta
import os

fake = Faker()

start_date_t1 = datetime(2000, 1, 1)
end_date_t1 = datetime(2004, 12, 31)  # Okres dla T1
start_date_t2 = datetime(2004, 1, 1)
end_date_t2 = datetime(2006, 12, 31)  # Okres dla T2

output_folder = "inventory-management-system"
os.makedirs(output_folder, exist_ok=True)

materials_df_t1 = pd.read_csv("material-orderding-system/materials_t1.csv", sep=';')[['MaterialID', 'MaterialName']]
materials_df_t2 = pd.read_csv("material-orderding-system/materials_t2.csv", sep=';')[['MaterialID', 'MaterialName']]

all_materials_df = pd.concat([materials_df_t1, materials_df_t2], ignore_index=True)

def generate_warehouses(n, start_id=0):
    warehouses = []
    for i in range(n):
        warehouses.append({
            "WarehouseID": f"WH{i + start_id:04d}",
            "WarehouseName": fake.company()[:20],
            "Location": fake.city()[:20]
        })
    return pd.DataFrame(warehouses)

warehouses_df_t1 = generate_warehouses(100)
warehouses_df_t2 = generate_warehouses(2, start_id=100)

def generate_warehouse_materials(n, warehouses_df, materials_df, start_id=0):
    warehouse_materials = []
    for i in range(n):
        warehouse_materials.append({
            "WarehouseMaterialID": f"WM{i + start_id:06d}",
            "WarehouseID": random.choice(warehouses_df['WarehouseID']),
            "MaterialID": random.choice(materials_df['MaterialID']),
            "QuantityInStock": random.randint(1, 5000),
            "LastUpdated": random_date(start_date_t1, end_date_t2)
        })
    return pd.DataFrame(warehouse_materials)

def random_date(start, end):
    return start + timedelta(days=random.randint(0, (end - start).days))

def generate_transfers(n, warehouses_df, projects_df, start_id=0, start_date=start_date_t1, end_date=end_date_t1):
    transfers = []
    for i in range(n):
        transfer_date = random_date(start_date, end_date)
        transfer_cost = round(random.uniform(50, 1000), 2)

        transfers.append({
            "TransferID": f"TR{i + start_id:06d}",
            "WarehouseID": random.choice(warehouses_df['WarehouseID']),
            "ProjectID": random.choice(projects_df['ProjectID']),
            "TransferCost": transfer_cost,
            "TransferDate": transfer_date
        })
    return pd.DataFrame(transfers)

def generate_part_of_transfers(n, transfers_df, warehouse_materials_df, start_id=0, decrease_rate=0.98):
    part_of_transfers = []
    for i in range(n):
        transfer_date = random_date(start_date_t1, end_date_t2)
        years_elapsed = (transfer_date - start_date_t1).days // 365

        quantity_moved = random.randint(1, 1000)
        lost_quantity = max(0, int(quantity_moved * (0.1 * (decrease_rate ** years_elapsed))))  # zmniejsza LostQuantity z czasem

        part_of_transfers.append({
            "PartOfTransferID": f"PT{i + start_id:07d}",
            "TransferID": random.choice(transfers_df['TransferID']),
            "WarehouseMaterialID": random.choice(warehouse_materials_df['WarehouseMaterialID']),
            "QuantityMoved": quantity_moved,
            "LostQuantity": lost_quantity
        })
    return pd.DataFrame(part_of_transfers)


n_warehouse_materials = 5000
n_transfers_t1 = 500000
n_transfers_t2 = 500000
n_part_of_transfers_t1 = 500000
n_part_of_transfers_t2 = 500000

warehouse_materials_df_t1 = generate_warehouse_materials(n_warehouse_materials, warehouses_df_t1, materials_df_t1)
warehouse_materials_df_t2 = generate_warehouse_materials(n_warehouse_materials, warehouses_df_t2, all_materials_df, start_id=n_warehouse_materials)

projects_df = pd.read_csv("material-orderding-system/projects_t1.csv", sep=';')

transfers_df_t1 = generate_transfers(n_transfers_t1, warehouses_df_t1, projects_df)
transfers_df_t2 = generate_transfers(n_transfers_t2, warehouses_df_t2, projects_df, start_date=start_date_t2, end_date=end_date_t2, start_id=n_transfers_t1)

part_of_transfers_df_t1 = generate_part_of_transfers(n_part_of_transfers_t1, transfers_df_t1, warehouse_materials_df_t1)
part_of_transfers_df_t2 = generate_part_of_transfers(n_part_of_transfers_t2, transfers_df_t2, warehouse_materials_df_t2, start_id=n_part_of_transfers_t1)


warehouses_df_t1.to_csv("inventory-management-system/warehouses_t1.csv", sep=';', index=False)
warehouses_df_t2.to_csv("inventory-management-system/warehouses_t2.csv", sep=';', index=False)
materials_df_t1.to_csv("inventory-management-system/materials_t1.csv", sep=';', index=False)
materials_df_t2.to_csv("inventory-management-system/materials_t2.csv", sep=';', index=False)
warehouse_materials_df_t1.to_csv("inventory-management-system/warehouse_materials_t1.csv", sep=';', index=False)
warehouse_materials_df_t2.to_csv("inventory-management-system/warehouse_materials_t2.csv", sep=';', index=False)
transfers_df_t1.to_csv("inventory-management-system/transfers_t1.csv", sep=';', index=False)
transfers_df_t2.to_csv("inventory-management-system/transfers_t2.csv", sep=';', index=False)
part_of_transfers_df_t1.to_csv("inventory-management-system/part_of_transfers_t1.csv", sep=';', index=False)
part_of_transfers_df_t2.to_csv("inventory-management-system/part_of_transfers_t2.csv", sep=';', index=False)
