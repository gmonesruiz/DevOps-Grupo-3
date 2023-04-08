Buscar en el sitio de MongoDB Atlas el ORG_ID

export ORG_ID=642887b0

En el sitio de MongoDB Atlas generar una API KEY

Save API Key Information
Public Key
export ATLAS_PUBLIC_KEY=atlaspbkey

Copy
Private Key
export ATLAS_PRIVATE_KEY=c85695a5


Con los datos obtenidos ejecutar el siguiente comando

kubectl create secret generic mongodb-atlas-operator-api-key \
    --from-literal="orgId=$ORG_ID" \
    --from-literal="publicApiKey=$ATLAS_PUBLIC_KEY" \
    --from-literal="privateApiKey=$ATLAS_PRIVATE_KEY" \
    -n mongodb-atlas-system
    
Etiquetarlo

kubectl label secret mongodb-atlas-operator-api-key atlas.mongodb.com/type=credentials -n mongodb-atlas-system


Agregar el password de la base de datos a los secrets

kubectl create secret generic atlaspassword --from-literal="password=mipassword"

Etiquetarlo

kubectl label secret atlaspassword atlas.mongodb.com/type=credentials


El siguiente comando nos revela los datos de conexion

kubectl get secret dev-grupo3-project-cluster0-jose10000 -o json | jq -r '.data | with_entries(.value |= @base64d)'


cambiar esta parte del deployment

          env: 
            - name: PORT
              value: "3000"
            - name: "MONGO_URI"
              valueFrom:
                secretKeyRef:
                  name: dev-grupo3-project-cluster0-jose10000
                  key: connectionStringStandardSrv
                  

