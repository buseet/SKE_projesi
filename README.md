# SKE Projesi

## Contributing
 - Make whatever changes you like,
 - Test locally:
    ```bash
    uv sync
    source .venv/bin/activate
    flask run --debug
    ```
    This should launch a local version of the web app, that you can access at 
    [127.0.0.1:5000]().
 - If you're happy with the results, then commit and push your changes.
 - Log in to the AWS server and update the docker container:
 ```bash
 # log into the AWS server:
 ssh USERNAME@donfax.com

 # navigate to the app git repo
 cd /home/jcranney/ske.donfax.com/SKE_projesi
 # get latest version from github
 git pull
 # go up to app root directory
 cd ..
 # shut down docker container running the app
 docker compose down
 # rebuild and launch the docker container (in detached mode)
 docker compose up -d --build
 ```
 If all went well then your changes should be ready at [ske.donfax.com]().