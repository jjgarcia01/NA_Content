namespace: stuff
flow:
  name: getStockPrice
  inputs:
    - stockTicker
    - myURL: "${get_sp('ninja_api_url')}"
  workflow:
    - get_stock_info:
        do:
          io.cloudslang.base.http.http_client_get:
            - url: "${myURL+'/v1/stockprice?ticker='+stockTicker}"
            - auth_type: anonymous
            - trust_all_roots: 'true'
            - headers: 'X-Api-Key: +1f1RjdxfroeF7yocE3rpA==twWzggWiZpGOwPNu'
        publish:
          - json_object: '${return_result}'
          - price1: '${cs_json_query(return_result,"price")}'
        navigate:
          - SUCCESS: find_price_in_json
          - FAILURE: on_failure
    - find_price_in_json:
        do:
          io.cloudslang.base.json.json_path_query:
            - json_object: '${json_object}'
            - json_path: price
        publish:
          - price: '${return_result}'
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  outputs:
    - price: '${price}'
    - stock_info: '${json_object}'
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      get_stock_info:
        x: 120
        'y': 200
      find_price_in_json:
        x: 320
        'y': 200
        navigate:
          249a5cbb-0d6d-d3ec-b0fe-869852b1163a:
            targetId: 401bc90b-c90b-ca17-a223-97c435ca688c
            port: SUCCESS
    results:
      SUCCESS:
        401bc90b-c90b-ca17-a223-97c435ca688c:
          x: 520
          'y': 200
