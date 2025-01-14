
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

## Final Step:

1. Open and update the following files to include your GCP Project ID:
   - `ad_placement_analysis.py`
   - `job_config.yaml`

2. This completes the setup. Your application is now ready for further development and deployment.





