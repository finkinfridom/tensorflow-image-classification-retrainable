# Retrainable Tensorflow image classification model - Docker based

run `docker build . -t [image_name]:[tag]`

once image is built you can

`docker run [image_name]:[tag] python scripts/classify_image.py __tests__/test_input.jpg`

to see the result
