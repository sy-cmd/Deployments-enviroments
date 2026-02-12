## we need a policy that allows us to create a bucket 

a policy in the IAM roles was created 

with the following steps 

````
Name: ObjectStorageLifecyclePolicy

Description: Allowing OS service to manage bucket lifecycles

Compartment: Keep it at syfalanga (root).

Policy Builder: Click the toggle switch that says "Show manual editor". This will give you a big text box.

Policy Statement: Paste this exact line into that box: with the needed region 
`Allow service objectstorage-af-johannesburg-1 to manage object-family in tenancy`
````