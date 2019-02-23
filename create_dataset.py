import turicreate as tc

# Folder filled with images
images = tc.loead_images('~/Downloads/')
images.explore()

# CSV with annotations corresponding to the images
annotations = tc.SFrame('annotations.csv')

# Overall dataset
data = images.join(annotations)

model = tc.image_classifier.create(data)
