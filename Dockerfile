FROM tensorflow/tensorflow:latest

WORKDIR /tf

ARG TRAINING_STEPS=8000
ARG TEST_FILE=test_input.jpg

RUN echo "TRAINING_STEPS: $TRAINING_STEPS" \
    echo "TEST_FILE: $TEST_FILE"


RUN pip install tensorflow_hub

COPY ./scripts ./scripts/

CMD ["sh", "-c", "python scripts/retrain.py --bottleneck_dir=tf_files/bottlenecks \
    --how_many_training_steps $TRAINING_STEPS \
    --model_dir=tf_files/inception \
    --output_graph=tf_files/output/retrained_graph.pb \
    --output_labels=tf_files/output/retrained_labels.txt \
    --image_dir ./photos && python scripts/label_image.py \
    --graph=tf_files/output/retrained_graph.pb \
    --labels=tf_files/output/retrained_labels.txt \
    --input_layer=Placeholder \
    --output_layer=final_result \
    --image=__tests__/$TEST_FILE" ]