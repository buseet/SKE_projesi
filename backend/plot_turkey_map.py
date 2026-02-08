import geopandas as gpd  # type: ignore
import pandas as pd  # type: ignore
import matplotlib.pyplot as plt
import os
import matplotlib.patches as mpatches  # To create custom legend handles


def make_plot_from_file(
    file, output_name="iller_harita_subat2026.png"
):
    # Read the Excel file with proper encoding (using openpyxl)
    province_data = pd.read_excel(file, engine='openpyxl')
    # Check the first few rows to make sure it looks good
    print(province_data.head())

    # Directory where all the province shapefiles are stored
    shapefile_directory = "tr_shp"  # Replace with the actual folder path

    # Initialize an empty list to hold all province GeoDataFrames
    gdf_list = []

    # Loop through each shapefile in the directory and read it with encoding
    for filename in os.listdir(shapefile_directory):
        if filename.endswith(".shp"):  # Only process shapefiles
            file_path = os.path.join(shapefile_directory, filename)
            # Read the shapefile with the appropriate encoding
            province_gdf = gpd.read_file(file_path, encoding='utf-8')  # or try 'windows-1254' if 'utf-8' doesn't work
            gdf_list.append(province_gdf)

    # Concatenate all the individual province GeoDataFrames into one
    gdf_all_provinces = gpd.GeoDataFrame(pd.concat(gdf_list, ignore_index=True))  # Concatenating with pandas

    # Check the columns in the shapefile
    print(gdf_all_provinces.columns)

    # Merge the shapefile data with the Excel file based on the 'id' column (matching province id)
    gdf_all_provinces = gdf_all_provinces.merge(province_data, left_on='id', right_on='id', how='left')

    # Fill NaN values in the 'SANAYİDE KADIN ELİ PROJESİ' column with 'Unknown'
    gdf_all_provinces['SANAYİDE KADIN ELİ PROJESİ'].fillna('Unknown', inplace=True)

    # Define the color map for statuses, including a default color for 'Unknown'
    color_map = {
        "Aktif": "indianred",
        "Planlıyor": "wheat",
        "Devam Ettirmiyor": "darkgray",
        "Yok": "white",  # Default color for unknown status
    }

    # Map the 'status' to the corresponding color
    gdf_all_provinces['color'] = gdf_all_provinces['SANAYİDE KADIN ELİ PROJESİ'].map(color_map)

    # Plot the map with colored provinces
    fig, ax = plt.subplots(1, 1, figsize=(25, 10))

    # Plot provinces with specified color and black borders
    gdf_all_provinces.plot(ax=ax, color=gdf_all_provinces['color'], edgecolor='black', linewidth=0.4)

    # Add province names from the Excel file (real Turkish names) to the center of each province
    # Use the correct column name for province name (i.e., 'province name')
    for idx, row in gdf_all_provinces.iterrows():
        # Get the centroid of the province
        centroid = row['geometry'].centroid
        # Use the 'province name' from the Excel file for the real Turkish names
        # ax.text(centroid.x, centroid.y, row['capital name'], fontsize=8, ha='center', va='center', color='black', fontweight='bold', fontname='DejaVu Sans')
        if row['il'] == 'Antalya':
            ax.text(centroid.x, centroid.y + 0.1, row['il'], fontsize=9, ha='center', va='bottom', color='black', fontweight='bold', fontname='DejaVu Sans')
        else:
            ax.text(centroid.x, centroid.y, row['il'], fontsize=9, ha='center', va='center', color='black', fontweight='bold', fontname='DejaVu Sans')

    # Create the legend handles manually
    legend_handles = [
        mpatches.Patch(color="indianred", label="Aktif"),
        mpatches.Patch(color="wheat", label="Planlıyor"),
        mpatches.Patch(color="darkgray", label="Devam Ettirmiyor")]

    # Add the legend in the upper right corner using bbox_to_anchor
    ax.legend(handles=legend_handles, loc='upper right', bbox_to_anchor=(1, 1))

    # Show the plot
    plt.title("SANAYİDE KADIN ELİ PROJESİ ÖZET RAPORU (2021 & 2025)", fontsize=16, fontweight='bold')
    plt.axis('off')  # Optionally turn off the axis
    plt.savefig(output_name, dpi=300, bbox_inches='tight')
    # plt.show()


def make_plot_from_json(
    data, output_name="iller_harita_subat2026.png"
):
    # Read the Excel file with proper encoding (using openpyxl)
    # province_data = pd.read_excel(file, engine='openpyxl')
    province_data = pd.json_normalize(data)

    # Check the first few rows to make sure it looks good
    print(province_data.head())

    # Directory where all the province shapefiles are stored
    shapefile_directory = "tr_shp"  # Replace with the actual folder path

    # Initialize an empty list to hold all province GeoDataFrames
    gdf_list = []

    # Loop through each shapefile in the directory and read it with encoding
    for filename in os.listdir(shapefile_directory):
        if filename.endswith(".shp"):  # Only process shapefiles
            file_path = os.path.join(shapefile_directory, filename)
            # Read the shapefile with the appropriate encoding
            province_gdf = gpd.read_file(file_path, encoding='utf-8')  # or try 'windows-1254' if 'utf-8' doesn't work
            gdf_list.append(province_gdf)

    # Concatenate all the individual province GeoDataFrames into one
    gdf_all_provinces = gpd.GeoDataFrame(pd.concat(gdf_list, ignore_index=True))  # Concatenating with pandas

    # Check the columns in the shapefile
    print(gdf_all_provinces.columns)

    # Merge the shapefile data with the Excel file based on the 'id' column (matching province id)
    gdf_all_provinces = gdf_all_provinces.merge(province_data, left_on='id', right_on='id', how='left')

    # Fill NaN values in the 'SANAYİDE KADIN ELİ PROJESİ' column with 'Unknown'
    gdf_all_provinces['SANAYİDE KADIN ELİ PROJESİ'].fillna('Unknown', inplace=True)

    # Define the color map for statuses, including a default color for 'Unknown'
    color_map = {
        "Aktif": "indianred",
        "Planlıyor": "wheat",
        "Devam Ettirmiyor": "darkgray",
        "Yok": "white",  # Default color for unknown status
    }

    # Map the 'status' to the corresponding color
    gdf_all_provinces['color'] = gdf_all_provinces['SANAYİDE KADIN ELİ PROJESİ'].map(color_map)

    # Plot the map with colored provinces
    fig, ax = plt.subplots(1, 1, figsize=(25, 10))

    # Plot provinces with specified color and black borders
    gdf_all_provinces.plot(ax=ax, color=gdf_all_provinces['color'], edgecolor='black', linewidth=0.4)

    # Add province names from the Excel file (real Turkish names) to the center of each province
    # Use the correct column name for province name (i.e., 'province name')
    for idx, row in gdf_all_provinces.iterrows():
        # Get the centroid of the province
        centroid = row['geometry'].centroid
        # Use the 'province name' from the Excel file for the real Turkish names
        # ax.text(centroid.x, centroid.y, row['capital name'], fontsize=8, ha='center', va='center', color='black', fontweight='bold', fontname='DejaVu Sans')
        if row['il'] == 'Antalya':
            ax.text(centroid.x, centroid.y + 0.1, row['il'], fontsize=9, ha='center', va='bottom', color='black', fontweight='bold', fontname='DejaVu Sans')
        else:
            ax.text(centroid.x, centroid.y, row['il'], fontsize=9, ha='center', va='center', color='black', fontweight='bold', fontname='DejaVu Sans')

    # Create the legend handles manually
    legend_handles = [
        mpatches.Patch(color="indianred", label="Aktif"),
        mpatches.Patch(color="wheat", label="Planlıyor"),
        mpatches.Patch(color="darkgray", label="Devam Ettirmiyor")]

    # Add the legend in the upper right corner using bbox_to_anchor
    ax.legend(handles=legend_handles, loc='upper right', bbox_to_anchor=(1, 1))

    # Show the plot
    plt.title("SANAYİDE KADIN ELİ PROJESİ ÖZET RAPORU (2021 & 2025)", fontsize=16, fontweight='bold')
    plt.axis('off')  # Optionally turn off the axis
    plt.savefig(output_name, dpi=300, bbox_inches='tight')
    # plt.show()

if __name__ == "__main__":
    make_plot_from_file("iller_liste_SKE.xlsx", "out.png")