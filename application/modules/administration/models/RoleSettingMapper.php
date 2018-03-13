<?php
/*
Copyright © 2014 TestArena

This file is part of TestArena.

TestArena is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

The full text of the GPL is in the LICENSE file.
*/
class Administration_Model_RoleSettingMapper extends Custom_Model_Mapper_Abstract
{
  protected $_dbTableClass = 'Administration_Model_RoleSettingDbTable';
  
  public function addSettings(Application_Model_Role $role)
  {
    $db           = $this->_getDbTable();
    $adapter      = $db->getAdapter();
    $data         = array();
    $roleSettings = $role->getRoleSettings();
    $values       = implode(',', array_fill(0, count($roleSettings), '(?, ?)'));
    
    foreach ($roleSettings as $setting)
    {
      $data[] = $role->getId();
      $data[] = $setting->getRoleAction()->getId();
    }

    $statement = $adapter->prepare('INSERT INTO '.$db->getName().' (role_id, role_action_id) VALUES '.$values);
    return $statement->execute($data);
  }
  
  public function editSettings(Application_Model_Role $role)
  {
    $db           = $this->_getDbTable();
    $adapter      = $db->getAdapter();
    $data         = array();
    $roleSettings = $role->getRoleSettings();
    $values       = implode(',',array_fill(0,count($roleSettings),'(?, ?)'));
    
    $this->deleteSettings($role);
    
    foreach($roleSettings as $setting)
    {
      $data[] = $role->getId();
      $data[] = $setting->getRoleAction()->getId();
    }

    $statement = $adapter->prepare('INSERT INTO '.$db->getName().' (role_id, role_action_id) VALUES '.$values);
    
    return $statement->execute( $data );
  }
  
  public function deleteSettings(Application_Model_Role $role)
  {
    $db = $this->_getDbTable();
    
    return $db->delete(array('role_id = ?' => $role->getId()));
  }
  
  public function getForExportByProject(Application_Model_Project $project)
  {
    try
    {
      $rows = $this->_getDbTable()->getForExportByProject($project->getId());
    
      if ($rows === null)
      {
        return false;
      }
    }
    catch (Exception $e)
    {
      Zend_Registry::get('Zend_Log')->log($e->getMessage(), Zend_Log::ERR);
      return false;
    }
    
    return $rows->toArray();
  }
  
  public function addForImport(array $rows)
  {
    $db = $this->_getDbTable();
    
    foreach ($rows as $row)
    {
      $db->insert($row);
    }
  }
}