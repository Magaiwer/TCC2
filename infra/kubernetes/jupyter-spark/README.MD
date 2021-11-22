## Acesso ao laboratório jupyter-spark tunelamento local
    sh -L localhost:8001:127.0.0.1:8001 univates@177.44.248.46
    kubectl port-forward -n spark service/jupyter 8888:8888