<?php

require_once WWW_ROOT . 'dao' . DIRECTORY_SEPARATOR . 'DAO.php';

class UsersDAO extends DAO {
    
  public function selectAll() {
    $sql = "SELECT * 
    				FROM `insp_users`";
    $stmt = $this->pdo->prepare($sql);
    $stmt->execute();
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
  }    

	public function selectById($id) {
		$sql = "SELECT * 
						FROM `insp_users` 
						WHERE `id` = :id";
		$stmt = $this->pdo->prepare($sql);
		$stmt->bindValue(':id', $id);
		$stmt->execute();
		$result = $stmt->fetch(PDO::FETCH_ASSOC);
		if($result){
			return $result;
		}
		return [];
	}

	public function insert($data) {
		$sql = "INSERT INTO `insp_users` (`email`, `password`) 
						VALUES (:email, :password)";
		$stmt = $this->pdo->prepare($sql);
		$stmt->bindValue(':email', $data['email']);
		$stmt->bindValue(':password', $data['password']);
		if($stmt->execute()) {
			$insertedId = $this->pdo->lastInsertId();
			return $this->selectById($insertedId);
		}
		return false;
	}

	public function selectByEmail($email) {
		$sql = "SELECT * FROM `insp_users` WHERE `email` = :email";
		$stmt = $this->pdo->prepare($sql);
		$stmt->bindValue(':email', $email);
		$stmt->execute();
		return  $stmt->fetch(PDO::FETCH_ASSOC);
	}

}