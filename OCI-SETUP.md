# 🚀 Configuração GitHub Actions + OCI Deploy

Este guia explica como configurar o deploy automático na Oracle Cloud Infrastructure (OCI) usando GitHub Actions.

## 📋 Pré-requisitos na OCI

### 1. Container Registry
- Acesse OCI Console > Developer Services > Container Registry
- Crie um repositório: `hello-world-nginx`
- Anote a URL do registry (ex: `iad.ocir.io`)

### 2. Compartment
- Use um compartment existente ou crie um novo
- Anote o OCID do compartment

### 3. Networking (VCN e Subnet)
- Crie ou use uma VCN existente
- Crie uma subnet pública
- Configure Security List para permitir tráfego na porta 9090:
  - Ingress Rule: 0.0.0.0/0 TCP 9090

### 4. IAM User e Políticas
```bash
# Política para Container Registry
Allow group <GROUP_NAME> to manage repos in compartment <COMPARTMENT_NAME>
Allow group <GROUP_NAME> to read repos in tenancy

# Política para Container Instances
Allow group <GROUP_NAME> to manage container-instances in compartment <COMPARTMENT_NAME>
Allow group <GROUP_NAME> to manage container-instance-families in compartment <COMPARTMENT_NAME>

# Política para VCN
Allow group <GROUP_NAME> to use virtual-network-family in compartment <COMPARTMENT_NAME>
```

## 🔐 Secrets do GitHub

Configure os seguintes secrets no seu repositório GitHub:
**Settings > Secrets and variables > Actions > New repository secret**

### Secrets Obrigatórios:

| Secret | Descrição | Exemplo |
|--------|-----------|---------|
| `OCI_REGISTRY_URL` | URL do Container Registry | `iad.ocir.io` |
| `OCI_NAMESPACE` | Namespace do seu tenancy | `idxxxxxxxx` |
| `OCI_USERNAME` | Username OCI | `<tenancy-namespace>/<username>` |
| `OCI_AUTH_TOKEN` | Auth Token OCI | `xxxxxxxxxxxxx` |
| `OCI_USER_OCID` | OCID do usuário | `ocid1.user.oc1..aaaaa...` |
| `OCI_TENANCY_OCID` | OCID do tenancy | `ocid1.tenancy.oc1..aaaaa...` |
| `OCI_COMPARTMENT_OCID` | OCID do compartment | `ocid1.compartment.oc1..aaaaa...` |
| `OCI_FINGERPRINT` | Fingerprint da API Key | `xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx` |
| `OCI_PRIVATE_KEY` | Chave privada da API Key | `-----BEGIN PRIVATE KEY-----\n...` |
| `OCI_SUBNET_OCID` | OCID da subnet | `ocid1.subnet.oc1..aaaaa...` |
| `OCI_AVAILABILITY_DOMAIN` | Availability Domain | `kWVD:US-ASHBURN-AD-1` |

## 📝 Como obter os valores dos Secrets

### 1. OCI_REGISTRY_URL e OCI_NAMESPACE
```bash
# No OCI Console > Container Registry
# URL: Região do registry (ex: iad.ocir.io)
# Namespace: Visível no canto superior direito da tela
```

### 2. OCI_USERNAME e OCI_AUTH_TOKEN
```bash
# OCI Console > Identity > Users > Seu usuário
# Username formato: <tenancy-namespace>/<username>
# Auth Token: User Details > Auth Tokens > Generate Token
```

### 3. OCIDs (User, Tenancy, Compartment, Subnet)
```bash
# OCI Console > Identity > Users > Seu usuário > User Information
# Tenancy OCID: Canto superior direito > Tenancy Information
# Compartment OCID: Identity > Compartments > Seu compartment
# Subnet OCID: Networking > Virtual Cloud Networks > Sua VCN > Subnets
```

### 4. API Key (Fingerprint e Private Key)
```bash
# Gerar par de chaves RSA
openssl genrsa -out ~/.oci/oci_api_key.pem 2048
openssl rsa -pubout -in ~/.oci/oci_api_key.pem -out ~/.oci/oci_api_key_public.pem

# OCI Console > Identity > Users > Seu usuário > API Keys > Add API Key
# Upload o arquivo oci_api_key_public.pem
# Copie o fingerprint mostrado
# Para o secret OCI_PRIVATE_KEY, use o conteúdo do arquivo oci_api_key.pem
```

### 5. OCI_AVAILABILITY_DOMAIN
```bash
# OCI Console > Compute > Instances > Create Instance
# O Availability Domain será listado no dropdown
# Formato: kWVD:US-ASHBURN-AD-1
```

## 🛠️ Script de Ajuda para Obter OCIDs

Crie este script para obter informações facilmente:

```bash
#!/bin/bash
# get-oci-info.sh

echo "=== Informações OCI ==="
echo "User OCID:"
oci iam user list --query 'data[?name==`<seu-username>`].id | [0]' --raw-output

echo "Tenancy OCID:"
oci iam tenancy get --tenancy-id $(oci iam user list --query 'data[0]."compartment-id"' --raw-output) --query 'data.id' --raw-output

echo "Compartments:"
oci iam compartment list --query 'data[*].{Name:name, OCID:id}' --output table

echo "VCNs e Subnets:"
oci network vcn list --compartment-id <compartment-ocid> --query 'data[*].{Name:"display-name", OCID:id}' --output table
```

## 🚀 Como funciona o Deploy

1. **Trigger**: Push para branch `main` ou manual
2. **Build**: Constrói imagem Docker multi-arquitetura
3. **Push**: Envia para OCI Container Registry
4. **Deploy**: Cria/atualiza Container Instance na OCI
5. **Output**: Mostra IP público da aplicação

## 🔧 Personalização

### Alterar região OCI
```yaml
env:
  OCI_REGION: sa-saopaulo-1  # Altere para sua região
```

### Alterar recursos do container
```yaml
--shape-config '{"memory_in_gbs": 2, "ocpus": 1}'  # Mais recursos
```

### Usar Compute Instance em vez de Container Instance
Substitua o step de deploy por comandos SSH para seu Compute Instance.

## 🐛 Troubleshooting

### Erro de autenticação
- Verifique se todos os secrets estão corretos
- Confirme se a API Key está ativa no usuário OCI

### Erro de rede
- Verifique se a subnet está configurada corretamente
- Confirme se as Security Lists permitem tráfego na porta 9090

### Erro de permissões
- Revise as políticas IAM listadas acima
- Confirme se o usuário está no grupo correto

## 📊 Monitoramento

Após o deploy, você pode monitorar:
- **OCI Console**: Container Instances > Sua instância
- **Logs**: OCI Logging Service
- **Métricas**: OCI Monitoring Service
- **GitHub**: Actions tab para logs de deploy