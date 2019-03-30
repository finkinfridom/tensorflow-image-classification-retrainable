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


RUN pip install tensorflow_hub


# RUN apt update && yes | \
#     apt install git
# RUN git clone https://github.com/googlecodelabs/tensorflow-for-poets-2 git-repo

# WORKDIR /tf/git-repo

COPY $TESTS_FOLDER ./__tests__

COPY ./scripts/label_image.py ./scripts/label_image.py
COPY ./scripts/retrain.py ./scripts/retrain.py

CMD ["sh", "-c", "python scripts/retrain.py --bottleneck_dir=/bottlenecks \
    --how_many_training_steps $TRAINING_STEPS \
    --model_dir=/inception \
    --output_graph=/retrained_graph.pb \
    --output_labels=/retrained_labels.txt \
    --image_dir ./photos && python scripts/label_image.py \
    --graph=/retrained_graph.pb \
    --labels=/retrained_labels.txt \
    --input_layer=Placeholder \
    --output_layer=final_result \
    --image=__tests__/$TEST_FILE" ]