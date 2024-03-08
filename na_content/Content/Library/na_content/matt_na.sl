namespace: na_content
operation:
  name: matt_na
  inputs:
    - username
    - password:
        sensitive: true
    - target
    - api_url
    - login_url
  python_action:
    use_jython: false
    script: "# do not remove the execute function\n# pass in username, password, and things for the payload in execute \ndef execute(api_url,login_url,username,password,target):\n    \n    import requests\n    import json \n    import re \n    import datetime\n    from datetime import date\n\n\n#    api_url = \"https://na1.advantageinc.org/nom/api/automation/v1/wrapper\"\n\n   # requests.packages.urllib3.disable_warnings()\n\n####################################################\n# Retrieve OAuth2 Token\n####################################################\n    \n    # Use this URL to authenticate when NA/NNM are integrated\n#    loginurl = \"https://nnmi.advantageinc.org/idp/oauth2/token\"\n    # Use this URL to authenticate when NA is standalone\n    #loginurl = \"https://na1.advantageinc.org/nom-na/idp/oauth2/token\"\n\n    # I need create variables for username and password\n    payload='grant_type=password&username='+ username + '&password='+ password +'&client_id=id1&client_secret=secret1'\n    headers = {\n      'Content-Type': 'application/x-www-form-urlencoded',\n      'Cookie': 'JSESSIONID=c082kHsvKMtVDUr6yLf9lT0CmBmIIQg1f7LzxItp.nmccloudvm456; NMSOBTURATE=SP4217OMQDZVCN07D49JEWA55S7GI8NI',\n    }\n\n    response = requests.request(\"POST\", login_url, headers=headers, data=payload, verify=False)\n#    response.raise_for_status()\n    \n    resp = response.json()\n    token = 'Bearer ' + resp['access_token']\n\n\n###################################################\n# NA Operation: \n#\n# The script is hardcoded to list the \"adelaide\"\n# device. The full response is printed as well as\n# an example of referencing a single element from\n# the response.\n# \n###################################################\n\n    payload = json.dumps({\n      \"command\": \"list device\",\n      \"parameters\": {\n       \"host\": target\n      }\n    })\n    headers = {\n      'Content-Type': 'application/json',\n      'Authorization': token\n    }\n    \n\n    response = requests.request(\"POST\", api_url, headers=headers, data=payload, verify=False)\n#    response.raise_for_status()\n    \n    info = json.dumps(response.json(), indent = 3)\n    return {\"naOutput\" : info}"
  outputs:
    - naOutput: '${naOutput}'
  results:
    - SUCCESS
