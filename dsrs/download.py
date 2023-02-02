import zipfile
import requests

response = requests.get("https://figshare.com/ndownloader/files/37818966", stream=True)
with open("DSRS_pretrained_models.zip", "wb") as f:
    for chunk in response.iter_content(chunk_size=1024*1024*10):
        if chunk:  # filter out keep-alive new chunks
            f.write(chunk)
z = zipfile.ZipFile("DSRS_pretrained_models.zip")
z.extractall()
# z = zipfile.ZipFile("DSRS_pretrained_models.zip")
# z.extractall()