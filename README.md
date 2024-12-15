[![Open in Codespaces](https://classroom.github.com/assets/launch-codespace-2972f46106e565e64193e422d61a12cf1da4916b45550586e14ef0a7c637dd04.svg)](https://classroom.github.com/open-in-codespaces?assignment_repo_id=17229418)
# Pipeline de Análisis de Encuestas Universitarias

## Inventario de Artefactos

### Infraestructura (Terraform)
- `infrastructure/terraform/main.tf`: Definición de recursos AWS

### Visualización
- `reports/dashboard.pbix`: Dashboard principal en Power BI


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
