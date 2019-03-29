# Retrainable Tensorflow image classification model - Docker based

run `docker build . -t amaghini/tensorflow-image-classification-retrainable:latest`

once image is built you can

`docker run --env-file .env --mount src="$(pwd)/input_photos",target=/tf/git-repo/tf_files/photos,type=bind amaghini/tensorflow-image-classification-retrainable:latest`

to see the classification result for the test_input.jpg file

If you want to access the container, you can simply

`docker run -it amaghini/tensorflow-image-classification-retrainable:latest bash`
