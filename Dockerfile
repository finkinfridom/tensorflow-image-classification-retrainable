FROM tensorflow/tensorflow:latest

WORKDIR /tensorflow

ARG PHOTOS_FOLDER=./input_photos
ARG TRAINING_STEPS=1000
ARG TESTS_FOLDER=./__tests__

RUN echo "PHOTOS_FOLDER: $PHOTOS_FOLDER" \
    echo "TRAINING_STEPS: $TRAINING_STEPS" \
    echo "TESTS_FOLDER: $TESTS_FOLDER" \
    echo "TEST_FILE: $TEST_FILE"

RUN apt update && yes | \
    apt install git
RUN git clone https://github.com/googlecodelabs/tensorflow-for-poets-2

WORKDIR /tensorflow/tensorflow-for-poets-2

COPY $TESTS_FOLDER ./__tests__

COPY $PHOTOS_FOLDER ./tf_files/photos

RUN python scripts/retrain.py --bottleneck_dir=tf_files/bottlenecks \
    --how_many_training_steps $TRAINING_STEPS \
    --model_dir=tf_files/inception \
    --output_graph=tf_files/retrained_graph.pb \
    --output_labels=tf_files/retrained_labels.txt \
    --image_dir ./tf_files/photos

COPY ./scripts/classify_image.py ./scripts/classify_image.py
CMD [ "python", "scripts/classify_image.py", "__tests__/$TEST_FILE" ]