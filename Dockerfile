FROM tensorflow/tensorflow:latest

WORKDIR /tf

ARG PHOTOS_FOLDER=./input_photos
ARG TRAINING_STEPS=10000
ARG TESTS_FOLDER=./__tests__
ARG TEST_FILE=test_input.jpg

RUN echo "PHOTOS_FOLDER: $PHOTOS_FOLDER" \
    echo "TRAINING_STEPS: $TRAINING_STEPS" \
    echo "TESTS_FOLDER: $TESTS_FOLDER" \
    echo "TEST_FILE: $TEST_FILE"

RUN apt update && yes | \
    apt install git
RUN git clone https://github.com/googlecodelabs/tensorflow-for-poets-2 git-repo

WORKDIR /tf/git-repo

COPY $TESTS_FOLDER ./__tests__

COPY ./scripts/classify_image.py ./scripts/classify_image.py

CMD ["sh", "-c", "python scripts/retrain.py --bottleneck_dir=tf_files/bottlenecks \
    --how_many_training_steps $TRAINING_STEPS \
    --model_dir=tf_files/inception \
    --output_graph=tf_files/retrained_graph.pb \
    --output_labels=tf_files/retrained_labels.txt \
    --image_dir ./tf_files/photos && python scripts/classify_image.py __tests__/$TEST_FILE" ]