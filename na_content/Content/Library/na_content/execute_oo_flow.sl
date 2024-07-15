namespace: na_content
operation:
  name: execute_oo_flow
  inputs:
    - username
    - password:
        sensitive: true
  python_action:
    use_jython: false
    script: "# do not remove the execute function\n# pass in username, password, and things for the payload in execute \ndef execute(username,password):\n    \n    import requests\n    import json \n    import re \n    import datetime\n    from datetime import date\n\n\n#    api_url = \"https://na1.advantageinc.org/nom/api/automation/v1/wrapper\"\n\n   # requests.packages.urllib3.disable_warnings()\n\n####################################################\n# Retrieve OAuth2 Token\n####################################################\n    \n    # Use this URL to authenticate when NA/NNM are integrated\n#    loginurl = \"https://nnmi.advantageinc.org/idp/oauth2/token\"\n    # Use this URL to authenticate when NA is standalone\n    #loginurl = \"https://na1.advantageinc.org/nom-na/idp/oauth2/token\"\n\n    # I need create variables for username and password\n    payload='grant_type=password&username='+ username + '&password='+ password +'&client_id=id1&client_secret=secret1'\n    headers = {\n      'Authorization': 'Basic YmFzZTY0IGRlY29kZXI='\n       }\n\n#    response = requests.request(\"GET\", \"https://rpaoo.advantageinc.org:8443/oo/rest/version\", headers=headers,verify=False)\n#    response.raise_for_status()\n    response = requests.get(\"https://rpaoo.advantageinc.org:8443/oo/rest/version\", auth=('jj.garcia','MFS0ftware#'),verify=False)\n\n\n#    token = response.cookies.get('X-CSRF-TOKEN')\n    t = response.cookies.get_dict()\n    to = json.loads(t)\n    token = to['X-CSRF-TOKEN-OO']\n#    for c in response.cookies.get_dict(): \n#    co = response.cookies.get_dict() \n#    r = json.dumps(co)\n    \n#    for c in r :\n#        if c.name == 'X-CSRF-TOKEN-OO':\n#            token = c.value\n    #print(c.name +\"==>>\", c.value)\n#    token = response.cookies['X-CSRF-TOKEN']\n    \n#    token = cookie['X-CSRF-TOKEN']\n    \n#\n# The script is hardcoded to list the \"adelaide\"\n# device. The full response is printed as well as\n# an example of referencing a single element from\n# the response.\n# #\n###################################################\n\n#    payload = json.dump(api_payload)\n#    payload=api_payload\n#    headers = {\n#      'Content-Type': 'application/json',\n#      'Authorization': token\n#    }\n    \n\n#    response = requests.request(\"POST\", api_url, headers=headers, data=payload, verify=False)\n#    response.raise_for_status()\n    \n#    token = json.dumps(t.json(), indent = 3)\n#    return {\"output\" :  }\n    return {'output': token}"
  outputs:
    - output: '${output}'
  results:
    - SUCCESS
