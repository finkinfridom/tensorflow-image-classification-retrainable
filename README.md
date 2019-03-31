# Retrainable Tensorflow image classification model - Docker based

run `docker build . -t amaghini/tensorflow-image-classification-retrainable:latest`

---

Once image is built you can

`docker run --env-file .env --mount src="$(pwd)/__tests__",target=/tf/__tests__,type=bind --mount src="$(pwd)/input_photos",target=/tf/photos,type=bind --mount src="$(pwd)/tf_files/output",target=/tf/tf_files/output,type=bind amaghini/tensorflow-image-classification-retrainable:latest`

to see the classification result for the test_input.jpg file

---

Once trained, if you want to see the classification result for a different image you can

`docker run --mount src="$(pwd)/__tests__",target=/tf/__tests__,type=bind --mount src="$(pwd)/input_photos",target=/tf/photos,type=bind --mount src="$(pwd)/tf_files/output",target=/tf/tf_files/output,type=bind amaghini/tensorflow-image-classification-retrainable:latest python scripts/label_image.py --graph=tf_files/output/retrained_graph.pb --labels=tf_files/output/retrained_labels.txt --input_layer=Placeholder --output_layer=final_result --image=__tests__/$TEST_FILE`

---

If you want to access the container, you can simply

`docker run -it amaghini/tensorflow-image-classification-retrainable:latest bash`

---

## Notes

- retrain.py script coming from [https://raw.githubusercontent.com/tensorflow/hub/master/examples/image_retraining/retrain.py](https://raw.githubusercontent.com/tensorflow/hub/master/examples/image_retraining/retrain.py)
- label.py script coming from [https://raw.githubusercontent.com/tensorflow/tensorflow/master/tensorflow/examples/label_image/label_image.py](https://raw.githubusercontent.com/tensorflow/tensorflow/master/tensorflow/examples/label_image/label_image.py)
