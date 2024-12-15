# Proveedor AWS con el perfil 'cristian'
provider "aws" {
  profile = "terraform-admin"
  region  = var.region
}

# Definición de variables
variable "region" {
  description = "Región de AWS para los recursos"
  default     = "us-east-1"
}

# Crear un Bucket S3 para almacenar los archivos CSV
resource "aws_s3_bucket" "csv_bucket" {
  bucket = "upt-tu-opinion-cuenta"  # Asegúrate de que el nombre del bucket sea único
}

# Crear una base de datos en AWS Glue
resource "aws_glue_catalog_database" "csv_database" {
  name = "csv_database"
}

# Crear una tabla en Glue para los archivos CSV
resource "aws_glue_catalog_table" "csv_table" {
  name          = "csv_table"
  database_name = aws_glue_catalog_database.csv_database.name

  table_type = "EXTERNAL_TABLE"
  parameters = {
    "classification" = "csv"
  }

  storage_descriptor {
    location      = "s3://upt-tu-opinion-cuenta/"  # Cambia esto a la ruta de tu bucket
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"
    compressed    = false

    # Definir las columnas con los datos que proporcionaste
    columns {
      name = "facultad"
      type = "string"
    }
    columns {
      name = "escuela"
      type = "string"
    }
    columns {
      name = "encuestados"
      type = "string"
    }
    columns {
      name = "no encuestados"
      type = "string"
    }
    columns {
      name = "total"
      type = "String"
    }
    columns {
      name = "Calidad de la presentación"
      type = "String"
    }
    columns {
      name = "Ejecución del proceso"
      type = "string"
    }
    columns {
      name = "Aplicación de la evaluación"
      type = "string"
    }
    columns {
      name = "Formación actitudinal"
      type = "string"
    }
  
    # Información adicional de las columnas
    ser_de_info {
      serialization_library = "org.apache.hadoop.hive.serde2.OpenCSVSerde"
      parameters = {
        "separatorChar" = ","
        "quoteChar"     = "\""
      }
    }
  }
}

# Crear un Crawler de Glue para descubrir el esquema del archivo CSV
resource "aws_glue_crawler" "csv_crawler" {
  name            = "csv_crawler"
  role            = aws_iam_role.glue_role.arn  # Asegúrate de que el role de IAM esté creado
  database_name   = aws_glue_catalog_database.csv_database.name
  s3_target {
    path = "s3://upt-tu-opinion-cuenta/"  # Cambia la ruta a tu bucket de S3
  }

  schedule = "cron(0 12 * * ? *)"  # Programar para que se ejecute diariamente
}

# Crear un role de IAM para Glue
resource "aws_iam_role" "glue_role" {
  name = "glue_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [ {
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "glue.amazonaws.com"
      }
    } ]
  })
}

# Adjuntar políticas a Glue Role
resource "aws_iam_role_policy_attachment" "glue_policy_attach" {
  role       = aws_iam_role.glue_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

# Nota: No es necesario crear un recurso de Athena Database aquí, ya que Glue maneja el catálogo
