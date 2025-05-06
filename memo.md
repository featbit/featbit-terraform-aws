# Setup aws credentials

## Linux

```bash
export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=
```

## Windows

1. Press Windows Key → search for “Environment Variables”

2. Click “Edit the system environment variables”

3. In the System Properties dialog, click Environment Variables

4. Under User variables (or System variables if for all users):

   - Click New

        - Variable name: AWS_ACCESS_KEY_ID

        - Variable value: your access key ID

   - Do the same for:

        - AWS_SECRET_ACCESS_KEY

5. Click OK on all dialogs.

# Workflow

## Init project

```bash
terraform init
```

## Format and validate code (Optional)

```bash
terraform fmt
```

```bash
terraform validate
```

## Create infrastructure

```bash
terraform apply
```

## Destroy infrastructure

```bash
terraform destroy
```

# Inspect state

```bash
terraform show
```