FROM postgres:latest

ADD . /

RUN apt-get update && apt-get install -y --no-install-recommends build-essential 
RUN gosu postgres /check_pgactivity --list

