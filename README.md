
## Guideline for Running the Script (scene_change_detection)

### How to Run the Script:

1. Save the script as `setup_video_analysis.sh` in your local environment.
2. Make the script executable by running the command:

   ```bash
   chmod +x setup_video_analysis.sh```

3. Execute the script:
```
./setup_video_analysis.sh
```

4. When prompted, enter your GCP Project ID.

## Explanation of What the Script Does:

### Step 1: Create a Google Cloud Storage Bucket
**Purpose:**  
The bucket will store input videos for analysis and hold the results. This ensures secure, scalable storage for application data.

---

### Step 2: Create and Configure a Service Account
**Purpose:**  
The service account allows secure access to GCP services like Artifact Registry, Vertex AI, and Cloud Storage. Necessary roles and permissions are granted to enable seamless integration.

---

### Step 3: Assign Roles to the Service Account
**Purpose:**  
The script ensures the service account has appropriate access to:
- **Artifact Registry** for managing Docker images.
- **Vertex AI** for running custom ML models.
- **Cloud Storage** for reading and writing data.

---

### Step 4: Download Required Application Files
**Purpose:**  
The essential files are fetched to set up the application:
- Python dependencies (`requirements.txt`).
- Instructions for building a Docker image (`Dockerfile`).
- Core application code (`ad_placement_analysis.py`).
- Data handling code (`gcp_data_handler.py`).
- Job configuration file for Vertex AI (`job_config.yaml`).

### Action:

Open and update the following files to include your GCP Project ID:
   - `ad_placement_analysis.py`
   - `job_config.yaml`

## Step 5: Build and Deploy the Docker Image

### Step 5-1: Create a Docker Repository
**Purpose:**  
To store Docker images in Google Artifact Registry, allowing easy management and deployment.

---

### Step 5-2: Build the Docker Image
**Purpose:**  
Package the application and its dependencies into a portable container for consistent and scalable deployment.

---

### Step 5-3: Tag the Docker Image
**Purpose:**  
Prepare the image for pushing to Artifact Registry by tagging it. Tagging ensures proper version control and organization.

---

### Step 5-4: Push the Docker Image to Artifact Registry
**Purpose:**  
Upload the tagged image to Artifact Registry, making it available for use in the GCP environment.

---

### Step 6: Run the Vertex AI Custom Job

To process videos, execute the following command:

```bash
gcloud ai custom-jobs create --region=us-central1 --config=job_config.yaml --display-name=my-custom-job
```

## Step 7: Explore Results in BigQuery

**Purpose:**  
Results from the job will be available in the `movie_output` table within the `movie_processing` dataset in BigQuery. Navigate there to review the structured analysis results.
s.

---

### Notes:

### Updating the Application:
If you make changes to the Python code (e.g., `ad_placement_analysis.py`), you need to re-build and re-push the Docker image:

```bash
docker build -t $IMAGE_NAME:latest .
docker tag $IMAGE_NAME:latest us-docker.pkg.dev/$PROJECT_ID/$REPO/$IMAGE_NAME:latest
docker push us-docker.pkg.dev/$PROJECT_ID/$REPO/$IMAGE_NAME:latest
```

## Step 7: Explore the Results in BigQuery

Once the job is complete, the results will be available in BigQuery. Navigate to BigQuery and locate the `movie_output` table within the `movie_processing` dataset. This table contains the results of the scene change detection in a structured format.

### Notes:

#### Updating the Application:
If changes are made to the Python code (e.g., `ad_placement_analysis.py`), re-build and re-push the Docker image:

```bash
docker build -t $IMAGE_NAME:latest .
docker tag $IMAGE_NAME:latest us-docker.pkg.dev/$PROJECT_ID/$REPO/$IMAGE_NAME:latest
docker push us-docker.pkg.dev/$PROJECT_ID/$REPO/$IMAGE_NAME:latest
```
### Processing New Videos:
Upload new videos to the `movie_processing_input` subfolder in the bucket and re-run the custom job:

```bash
gcloud ai custom-jobs create --region=us-central1 --config=job_config.yaml --display-name=my-custom-job
```




