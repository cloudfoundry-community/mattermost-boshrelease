# Pipeline

From root directory:

```
fly -t oss set-pipeline -p $(basename $(pwd)) -c ci/pipeline.yml -l ci/credentials.yml
```
