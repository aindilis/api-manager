import ee

ee.Initialize()

# Load an image.

landsat = ee.Image('LANDSAT/LC08/C01/T1_TOA/LC08_123032_20140515').select(['B4', 'B3', 'B2'])

geometry = ee.Geometry.Rectangle([116.2621, 39.8412, 116.4849, 40.01236])

llx = 116.2621
lly = 39.8412
urx = 116.4849
ury = 40.01236
geometry = [[llx,lly], [llx,ury], [urx,ury], [urx,lly]]

task_config = {
    'description': 'imageToAssetExample',
    'scale': 30,
    'region': geometry
   }

task = ee.batch.Export.image(landsat, 'exportExample', task_config)

task.start()
