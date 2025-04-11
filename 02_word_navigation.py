#!/usr/bin/env python3
# VIM WORD NAVIGATION PRACTICE
# Practice file for Steps 3-4: Word navigation (w, e, b) and line navigation (0, ^, $)

import os
import sys
import json
import logging
from typing import Dict, List, Optional, Union, Any

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[logging.StreamHandler()]
)
logger = logging.getLogger(__name__)

class ConfigManager:
    """Manages configuration settings for the application.
    
    Practice these motions:
    - w: move to start of next word
    - e: move to end of current/next word
    - b: move to beginning of current/previous word
    - 0: move to start of line
    - ^: move to first non-blank character of line
    - $: move to end of line
    """
    
    def __init__(self, config_path: str = "/etc/app/config.json"):
        self.config_path = config_path
        self.config = self._load_config()
        
    def _load_config(self) -> Dict[str, Any]:
        """Loads configuration from the specified path.
        
        Returns:
            Dict containing configuration values
        """
        try:
            if os.path.exists(self.config_path):
                with open(self.config_path, 'r') as f:
                    return json.load(f)
            else:
                logger.warning(f"Config file not found at {self.config_path}")
                return self._get_default_config()
        except Exception as e:
            logger.error(f"Failed to load config: {str(e)}")
            return self._get_default_config()
    
    def _get_default_config(self) -> Dict[str, Any]:
        """Returns default configuration values."""
        return {
            "app_name": "DevOpsApp",
            "environment": "development",
            "log_level": "INFO",
            "retry_attempts": 3,
            "timeout_seconds": 30,
            "features": {
                "enable_caching": True,
                "enable_metrics": False,
                "enable_notifications": True
            },
            "database": {
                "host": "localhost",
                "port": 5432,
                "username": "admin",
                "password": "password123",  # Practice navigating to this value and changing it!
                "name": "devops_db"
            }
        }
    
    def get_value(self, key: str, default: Any = None) -> Any:
        """Retrieves a configuration value by its key.
        
        Args:
            key: The configuration key to look up
            default: Value to return if key is not found
            
        Returns:
            The configuration value or default if not found
        """
        keys = key.split('.')
        value = self.config
        
        try:
            for k in keys:
                value = value[k]
            return value
        except (KeyError, TypeError):
            logger.debug(f"Config key not found: {key}, using default: {default}")
            return default
    
    def update_value(self, key: str, value: Any) -> bool:
        """Updates a configuration value.
        
        Args:
            key: The configuration key to update
            value: The new value
            
        Returns:
            True if update was successful, False otherwise
        """
        keys = key.split('.')
        config = self.config
        
        # Navigate to the correct nested dictionary
        for k in keys[:-1]:
            if k not in config:
                config[k] = {}
            config = config[k]
        
        # Update the value
        config[keys[-1]] = value
        
        try:
            with open(self.config_path, 'w') as f:
                json.dump(self.config, f, indent=2)
            return True
        except Exception as e:
            logger.error(f"Failed to update config: {str(e)}")
            return False


def main():
    """Main function to demonstrate the ConfigManager.
    
    Try navigating to different parts of this function using Vim motions.
    """
    config_manager = ConfigManager()
    
    # Get some configuration values
    app_name = config_manager.get_value("app_name")
    db_host = config_manager.get_value("database.host")
    cache_enabled = config_manager.get_value("features.enable_caching")
    
    # Log the current configuration
    logger.info(f"Application: {app_name}")
    logger.info(f"Database host: {db_host}")
    logger.info(f"Caching enabled: {cache_enabled}")
    
    # Update a configuration value
    if config_manager.update_value("database.password", "new_secure_password"):
        logger.info("Updated database password successfully")
    else:
        logger.error("Failed to update database password")
    
    # This is a very long line that you can practice navigating with 0, ^, and $ motions - try to move to the beginning, first non-whitespace character, and end of this line without using arrow keys
    
    # Practice word navigation on these variable names
    user_authentication_service = None
    database_connection_pool = None
    message_queue_processor = None
    infrastructure_provisioning_client = None
    
    return 0


if __name__ == "__main__":
    sys.exit(main())
