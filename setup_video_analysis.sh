#!/bin/bash

# Prompt the user for PROJECT_ID
read -p "Enter your GCP Project ID: " PROJECT_ID

# Define variables
REPO=gcr-video-analysis
IMAGE_NAME=ad_placement_analysis
SERVICE_ACCOUNT_NAME=ad-placement-service-account

BUCKET_NAME="bucket-$PROJECT_ID-video-analysis"
SUBFOLDER_NAME=movie_processing_input/
SERVICE_ACCOUNT_EMAIL="$SERVICE_ACCOUNT_NAME@$PROJECT_ID.iam.gserviceaccount.com"
USER_EMAIL=$(gcloud config get-value account)

# Create a GCS bucket
gsutil mb gs://$BUCKET_NAME/

# Copy files to the bucket
gsutil cp -r gs://video_demo_test/* gs://$BUCKET_NAME/$SUBFOLDER_NAME/

# Create a service account
gcloud iam service-accounts create $SERVICE_ACCOUNT_NAME \
  --display-name "Service Account for Vertex AI and Artifact Registry"

# Add IAM roles to the service account
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:$SERVICE_ACCOUNT_EMAIL" \
  --role="roles/artifactregistry.writer"
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:$SERVICE_ACCOUNT_EMAIL" \
  --role="roles/aiplatform.user"
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:$SERVICE_ACCOUNT_EMAIL" \
  --role="roles/aiplatform.admin"
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:$SERVICE_ACCOUNT_EMAIL" \
  --role="roles/storage.objectViewer"
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:$SERVICE_ACCOUNT_EMAIL" \
  --role="roles/storage.objectCreator"
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:$SERVICE_ACCOUNT_EMAIL" \
  --role="roles/storage.objectAdmin"
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:$SERVICE_ACCOUNT_EMAIL" \
  --role="roles/storage.admin"
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:$SERVICE_ACCOUNT_EMAIL" \
  --role="roles/bigquery.admin"

# Set up the video analysis application
mkdir video_analysis_app
cd video_analysis_app

wget https://raw.githubusercontent.com/AmirMK/GCP_workshop/main/requirements.txt
wget https://raw.githubusercontent.com/AmirMK/GCP_workshop/main/Dockerfile
wget https://raw.githubusercontent.com/AmirMK/GCP_workshop/main/ad_placement_analysis.py
wget https://raw.githubusercontent.com/AmirMK/GCP_workshop/main/gcp_data_handler.py
wget https://raw.githubusercontent.com/AmirMK/GCP_workshop/main/job_config.yaml

# Print completion message
echo "Setup completed successfully."
