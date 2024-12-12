[![Open in Codespaces](https://classroom.github.com/assets/launch-codespace-2972f46106e565e64193e422d61a12cf1da4916b45550586e14ef0a7c637dd04.svg)](https://classroom.github.com/open-in-codespaces?assignment_repo_id=17229418)
# Pipeline de Análisis de Encuestas Universitarias

## Estructura del Proyecto
```
survey-analysis-pipeline/
├── infrastructure/
│   ├── terraform/
│   │   ├── main.tf           # Configuración principal de Terraform
│   │   ├── variables.tf      # Variables de configuración
│   │   ├── outputs.tf        # Outputs de la infraestructura
│   │   └── backend.tf        # Configuración del backend de Terraform
│   └── scripts/
│       ├── deploy.sh         # Script de despliegue
│       └── destroy.sh        # Script de limpieza
├── src/
│   ├── lambda/
│   │   └── process_survey.py # Función Lambda para procesamiento
│   ├── glue/
│   │   └── etl_job.py       # Job de AWS Glue
│   └── sql/
│       ├── schema.sql       # Esquema de la base de datos
│       └── views.sql        # Vistas para análisis
├── data/
│   ├── raw/                 # Datos crudos de encuestas
│   └── processed/           # Datos procesados
├── reports/
│   ├── dashboard.pbix       # Dashboard en Power BI
│   └── quicksight/         # Análisis en QuickSight
├── tests/
│   └── test_etl.py         # Pruebas unitarias
├── .github/
│   └── workflows/
│       ├── terraform.yml    # Pipeline de CI/CD para infraestructura
│       └── etl.yml         # Pipeline de CI/CD para ETL
├── requirements.txt         # Dependencias Python
└── README.md               # Documentación principal
```

## Inventario de Artefactos

### Infraestructura (Terraform)
- `infrastructure/terraform/main.tf`: Definición de recursos AWS
- `infrastructure/terraform/variables.tf`: Variables configurables
- `infrastructure/terraform/outputs.tf`: Outputs de la infraestructura
- `infrastructure/terraform/backend.tf`: Configuración del estado de Terraform

### Procesamiento de Datos
- `src/lambda/process_survey.py`: Función Lambda para validación inicial
- `src/glue/etl_job.py`: Job de AWS Glue para transformación
- `src/sql/schema.sql`: Definición del esquema de base de datos
- `src/sql/views.sql`: Vistas SQL para análisis

### Visualización
- `reports/dashboard.pbix`: Dashboard principal en Power BI
- `reports/quicksight/`: Análisis y visualizaciones en QuickSight

### Automatización
- `.github/workflows/terraform.yml`: Pipeline de CI/CD para infraestructura
- `.github/workflows/etl.yml`: Pipeline de CI/CD para procesamiento de datos
- `infrastructure/scripts/deploy.sh`: Script de despliegue
- `infrastructure/scripts/destroy.sh`: Script de limpieza

## Enlaces de Publicación
- Repositorio: [GitHub - Survey Analysis Pipeline](#)
- Documentación: [Wiki del Proyecto](#)
- Dashboard: [Power BI Service](#)
- ETL Jobs: [AWS Glue Console](#)

## Despliegue

### Requisitos Previos
- AWS CLI configurado con credenciales apropiadas
- Terraform instalado (v1.0.0 o superior)
- Python 3.9 o superior
- Git

### Pasos de Despliegue Manual

1. Clonar el repositorio:
```bash
git clone https://github.com/your-org/survey-analysis-pipeline.git
cd survey-analysis-pipeline
```

2. Configurar variables de entorno:
```bash
export AWS_REGION=us-east-1
export TF_VAR_environment=dev
export TF_VAR_project_name=university-survey
```

3. Ejecutar el script de despliegue:
```bash
chmod +x infrastructure/scripts/deploy.sh
./infrastructure/scripts/deploy.sh
```

### Despliegue Automatizado

El proyecto está configurado con GitHub Actions para despliegue automático:

1. Los push a la rama `main` activarán el despliegue automático
2. Los pull requests ejecutarán validaciones sin desplegar
3. Verificar los workflows en la pestaña "Actions" de GitHub

### Monitoreo Post-Despliegue

1. Verificar el estado de la función Lambda:
```bash
aws lambda get-function --function-name university-survey-process
```

2. Monitorear el job de Glue:
```bash
python src/glue/monitor_glue_job.py
```

3. Revisar los logs en CloudWatch