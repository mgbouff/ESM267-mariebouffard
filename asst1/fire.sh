# Marie Bouffard
# ESM 267 GDAL data wrangling

set -x

# North Complex Fire
# 2020-08-18 to 2020-10-05
# Plumas and Butte counties
baseURL='https://wvs.earthdata.nasa.gov/api/v1/snapshot?REQUEST=GetSnapshot&&CRS=EPSG:4326&WRAP=DAY&LAYERS=MODIS_Terra_CorrectedReflectance_Bands721&FORMAT=image/jpeg&HEIGHT=2276&WIDTH=2276&BBOX=37,-125,42,-120&TIME='
dates='2020-08-18 2020-08-19 2020-08-20 2020-08-21 2020-08-22 2020-08-23 2020-08-24 2020-08-25 2020-08-26 2020-08-27 2020-08-28 2020-08-29 2020-08-30 2020-08-31 2020-09-01 2020-09-02 2020-09-03 2020-09-04 2020-09-05 2020-09-06 2020-09-07 2020-09-08 2020-09-09 2020-09-10 2020-09-11 2020-09-12 2020-09-13 2020-09-14 2020-09-15 2020-09-16 2020-09-17 2020-09-18 2020-09-19 2020-09-20 2020-09-21 2020-09-22 2020-09-23 2020-09-24 2020-09-25 2020-09-26 2020-09-27 2020-09-28 2020-09-29 2020-09-30 2020-10-01 2020-10-02 2020-10-03 2020-10-04 2020-10-05'

ogr2ogr \ 
# projection
-t_srs EPSG:3310 \
-overwrite \
# SQL
#Multiple Butte counties so just take CA one
-where "NAME = 'Plumas' OR NAME = 'Butte' AND STATEFP='06'" \
"Counties_Plumas_Bute/Counties_Plumas_Bute.shp" "tl_2018_us_county"

# Loop through dates

for date in $dates 
do
gdalwarp \
-t_srs EPSG:3310 \
-overwrite \
-cutline Counties_Plumas_Bute/Counties_Plumas_Bute.shp \
-crop_to_cutline \
-dstalpha \
"${baseURL}${dates}" "${dates}.tiff" 
done
