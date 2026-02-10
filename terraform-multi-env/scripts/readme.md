The scripts here they are used to automate the process of creating environments 

### Create PR Environment with scripts 
where `42` is the attribute given by the user when running the scripts 
```
cd ~/terraform-multi-env
./scripts/create-pr-env.sh 42


# Review the plan the environment created 
cd environments/pr-42
terraform apply tfplan
```

#### Destroy PR Environment
```
cd ~/terraform-multi-env
./scripts/destroy-pr-env.sh 42
```