
# spark

A `debian:jessie` based [Spark](http://spark.apache.org) container. Use it in a standalone cluster with the accompanying `docker-compose.yml`, or as a base for more complex recipes.

This repository is a fork of [gettyimages/docker-spark](https://github.com/gettyimages/docker-spark). 

## docker example

To run `SparkPi`, run the image with Docker:

    docker run --rm -it -p 4040:4040 gettyimages/spark bin/run-example SparkPi 10

To start `spark-shell` with your AWS credentials:

    docker run --rm -it -e "AWS_ACCESS_KEY_ID=YOURKEY" -e "AWS_SECRET_ACCESS_KEY=YOURSECRET" -p 4040:4040 gettyimages/spark bin/spark-shell

To do a thing with Pyspark

    echo "import pyspark\nprint(pyspark.SparkContext().parallelize(range(0, 10)).count())" > count.py
    docker run --rm -it -p 4040:4040 -v $(pwd)/count.py:/count.py gettyimages/spark bin/spark-submit /count.py

## docker-compose example

To create a simplistic standalone cluster with [docker-compose](http://docs.docker.com/compose):

    docker-compose up

The SparkUI will be running at `http://${YOUR_DOCKER_HOST}:8080` with one worker listed. To run `pyspark`, exec into a container:

    docker exec -it dockerspark_master_1 /bin/bash
    bin/pyspark

Then you can paste this code:

    RDDread = sc.textFile("file:///usr/spark-2.3.0/README.md")
    RDDread.first()
    RDDread.take(5)
    RDDread.takeSample(False, 10, 2)
    RDDread.count()


To run `SparkPi`, exec into a container:

    docker exec -it dockerspark_master_1 /bin/bash
    bin/run-example SparkPi 10

## jupyter example

To run Jupyter notebooks, exec into a container and run the jupyter server: 

    jupyter notebook --port 8889 --notebook-dir='/media/notebooks' --ip='*' --no-browser   --allow-root

Then you can create a new notebook and paste the following code inside one or more cells:

    import findspark
    findspark.init()
    import pyspark
    sc = pyspark.SparkContext(appName="test")
    RDDread = sc.textFile("file:///usr/spark-2.3.0/README.md")
    RDDread.first()
    RDDread.take(5)
    RDDread.takeSample(False, 10, 2)
    RDDread.count()

This is shown in the following figure:

![Example notebook](./example-notebook.png?raw=true)

## Spark streaming example

TO DO

## license

MIT
