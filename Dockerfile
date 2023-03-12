FROM ubuntu as builder
WORKDIR /sieve_c
RUN apt update && \
apt install -y build-essential clang
COPY pte_sieve/c .
RUN make

FROM python:slim-buster as runner
WORKDIR /sieve_py
COPY --from=builder sieve_c/test_sieve sieve_c/libsieve.so sieve_c/test_sieve_128 sieve_c/libsieve128.so ./pte_sieve/c/
COPY . .
ENV PATH $PATH:/sieve_py/pte_sieve
WORKDIR /sieve_py/pte_sieve
CMD [ "/bin/bash" ]
