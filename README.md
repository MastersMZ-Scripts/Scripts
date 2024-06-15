# MastersMZ scripts
This repository contains scripts made for MastersMZ.

[📽] If you showcase these scripts, please do not re-upload but provide the url for the script. 


## 📜 Loadstring creation:
If you want to create a loadstring, use this improved template: 
```lua
local function ExecuteURL(Url) 
  local Payload = request({
    Url = Url,
    Method = 'GET',
    Headers = {
      ['Content-Type'] = 'text/plain',
    }
  }).Body

  -- Error check
  if Payload:sub(1,3) == "404" then
    return warn("[!] The script you have requested has moved or been deleted.")
  end
  return loadstring(Payload)()
end

ExecuteURL('https://raw.githubusercontent.com/MastersMZ-Scripts/Scripts/main/plague%20rizz%20script.lua')
```
