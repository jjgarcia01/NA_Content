namespace: Customer.reporting
flow:
  name: getStockInfo
  inputs:
    - stockTicker:
        prompt:
          type: text
  workflow:
    - http_client_get:
        do:
          io.cloudslang.base.http.http_client_get:
            - url: "${'https://api.api-ninjas.com/v1/stockprice?ticker='+stockTicker}"
            - auth_type: Anonymous
            - trust_all_roots: 'true'
            - headers: 'X-Api-Key: +1f1RjdxfroeF7yocE3rpA==twWzggWiZpGOwPNu'
        publish:
          - stockInfoJson: '${return_result}'
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  outputs:
    - stockInfoJson: '${stockInfoJson}'
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      http_client_get:
        x: 200
        'y': 160
        navigate:
          2641615c-e8a1-ca79-2357-fae03130d660:
            targetId: 63186d57-bc6c-7a1a-4082-a5e65e916da5
            port: SUCCESS
    results:
      SUCCESS:
        63186d57-bc6c-7a1a-4082-a5e65e916da5:
          x: 600
          'y': 160
