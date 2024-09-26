# Logger para informar del progreso de los modelos.
import logging
from rich.logging import RichHandler
from rich.console import Console
from rich.table import Table

# Crear consola de Rich para mensajes personalizados.
console = Console()

def get_logger() -> logging.Logger:

    # Configuración del Logger.
    logging.basicConfig(
        level="INFO",  # Nivel de logging (DEBUG, INFO, WARNING, ERROR, CRITICAL)
        format="%(message)s",  # Formato de los mensajes de log
        datefmt="[%X]",  # Formato del tiempo
        handlers=[RichHandler()]  # Usar RichHandler para logs enriquecidos
    )

    # Crear una instancia de Logger.
    logger = logging.getLogger("rich_logger")

    # Retornar una instancia.
    return logger

def log_results(model_name, accuracy):
    table = Table(title=f"Resultados del Modelo {model_name}")

    table.add_column("Métrica", style="cyan", no_wrap=True)
    table.add_column("Valor", style="magenta")

    # Añadir métricas de evaluación (ejemplo)
    table.add_row("Precisión", accuracy.__str__())

    console.print(table)