# Retrainable Tensorflow image classification model - Docker based

run `docker build . -t [image_name]:[tag]`

once image is built you can

`docker run --env-file .env --mount src="/input_photos",target=/tensorflow/tensorflow-for-poets-2/tf_files/photos,type=bind [image_name]:[tag]`

to see the classification result for the test_input.jpg file

If you want to access the container, you can simply

`docker run -it [image_name]:[tag] bash`
