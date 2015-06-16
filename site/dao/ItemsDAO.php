<?php

require_once WWW_ROOT . 'dao' . DIRECTORY_SEPARATOR . 'DAO.php';

class ItemsDAO extends DAO {
    
  public function selectAll() {
    $sql = "SELECT * 
    				FROM `insp_items`";
    $stmt = $this->pdo->prepare($sql);
    $stmt->execute();
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
  }  



  public function selectAllPhotos() {
    $sql = "SELECT * 
    				FROM `badget_img`";
    $stmt = $this->pdo->prepare($sql);
    $stmt->execute();
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
  } 

  public function selectTotalBier() {
		$sql = "SELECT SUM(score) 
				FROM badget_data 
				WHERE spel = :spel";
		$stmt = $this->pdo->prepare($sql);
		$stmt->bindValue(':spel', "snellerdanjepint");
		$stmt->execute();
		$result = $stmt->fetch(PDO::FETCH_ASSOC);
		if($result){
			return $result;
		}
		return;
	}

	public function selectTotalPunten() {
		$sql = "SELECT SUM(score) 
				FROM badget_data 
				WHERE spel = :spel";
		$stmt = $this->pdo->prepare($sql);
		$stmt->bindValue(':spel', "versus");
		$stmt->execute();
		$result = $stmt->fetch(PDO::FETCH_ASSOC);
		if($result){
			return $result;
		}
		return;
	}     

	public function selectTotalPhotos() {
		$sql = "SELECT COUNT(id)
				FROM badget_img";
		$stmt = $this->pdo->prepare($sql);
		$stmt->execute();
		$result = $stmt->fetch(PDO::FETCH_ASSOC);
		if($result){
			return $result;
		}
		return;
	}   

	public function selectById($id) {
		$sql = "SELECT * 
						FROM `insp_items` 
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

	public function getWinnersBalans() {
		$sql = "SELECT * 
						FROM `badget_data` 
						WHERE `spel` = :spel
						ORDER BY score DESC LIMIT 3";
		$stmt = $this->pdo->prepare($sql);
		$stmt->bindValue(':spel', "versus");
		$stmt->execute();
		$result = $stmt->fetchAll(PDO::FETCH_ASSOC);
		if($result){
			return $result;
		}
		return [];
	}

	public function getWinnersLopen() {
		$sql = "SELECT * 
						FROM `badget_data` 
						WHERE `spel` = :spel
						ORDER BY score DESC LIMIT 3";
		$stmt = $this->pdo->prepare($sql);
		$stmt->bindValue(':spel', "snellerdanjepint");
		$stmt->execute();
		$result = $stmt->fetchAll(PDO::FETCH_ASSOC);
		if($result){
			return $result;
		}
		return [];
	}	



	public function selectByUserId($user_id) {
		$sql = "SELECT * 
						FROM `insp_items` 
						WHERE `user_id` = :user_id";
		$stmt = $this->pdo->prepare($sql);
		$stmt->bindValue(':user_id', $user_id);
		$stmt->execute();
		return $stmt->fetchAll(PDO::FETCH_ASSOC);
	}	

	public function selectByTag($tag) {
		$tag = "%#".$tag."%";
		$sql = "SELECT * 
						FROM `insp_items` 
						WHERE `text` LIKE :tag";
		$stmt = $this->pdo->prepare($sql);
		$stmt->bindValue(':tag', $tag);
		$stmt->execute();
		$result = $stmt->fetchAll(PDO::FETCH_ASSOC);
		if($result){
			return $result;
		}
		return [];
	}

	public function delete($id) {
		$sql = "DELETE 
						FROM `insp_items` 
						WHERE `id` = :id";
		$stmt = $this->pdo->prepare($sql);
		$stmt->bindValue(':id', $id);
		return $stmt->execute();
	}

	public function update($id, $data) {
		$errors = $this->getValidationErrors($data);
		if(empty($errors)) {
			$sql = "UPDATE `insp_items` 
							SET `text` = :text, 
							WHERE `id` = :id";
			$stmt = $this->pdo->prepare($sql);
			$stmt->bindValue(':text', $data['text']);
			$stmt->bindValue(':id', $id);
			if($stmt->execute()) {
				return $this->selectById($id);
			}
		}
		return false;
	}

	public function insert($data) {


		$errors = $this->getValidationErrors($data);
		if(empty($errors)) {
			$sql = "INSERT INTO `insp_items` (`text`,`user_id`,`type`,`title`)
							VALUES (:text, :user_id, :type, :title)";
			$stmt = $this->pdo->prepare($sql);
			$stmt->bindValue(':text', $data['text']);
			$stmt->bindValue(':user_id', $data['user_id']);
			$stmt->bindValue(':type', "text");
			$stmt->bindValue(':title', $data['title']);
			if($stmt->execute()) {
				$insertedId = $this->pdo->lastInsertId();
				return $this->selectById($insertedId);
			}
		}
		return false;
	}

	public function selectByHash($hash) {
		$sql = "SELECT * 
						FROM `insp_items` 
						WHERE `hash` = :hash";
		$stmt = $this->pdo->prepare($sql);
		$stmt->bindValue(':hash', $hash);
		$stmt->execute();
		$result = $stmt->fetch(PDO::FETCH_ASSOC);
		if($result){
			return $result;
		}
		return [];
	}

	public function insertimg($data) {
		$errors = $this->getValidationErrorsimg($data);
		if(empty($errors)) {
			$sql = "INSERT INTO `badget_img` (`path`, `pathbig`,`hash`,`name`) 
							VALUES (:path, :pathbig, :hash, :name)";
			$stmt = $this->pdo->prepare($sql);
			$stmt->bindValue(':path', $data['path']);
			$stmt->bindValue(':pathbig', $data['pathbig']);
			$stmt->bindValue(':hash', $data['hash']);
			$stmt->bindValue(':name', $data['username']);
			if($stmt->execute()) {
				$insertedId = $this->pdo->lastInsertId();
				return $this->selectById($insertedId);
			}
		}
		return false;
	}

	public function insertData($data) {
			$sql = "INSERT INTO `badget_data` (`spel`, `score`, `username`) 
							VALUES (:spel, :score, :username)";
			$stmt = $this->pdo->prepare($sql);
			$stmt->bindValue(':spel', $data['spel']);
			$stmt->bindValue(':score', $data['tijd']);
			$stmt->bindValue(':username', $data['username']);
			if($stmt->execute()) {
				$insertedId = $this->pdo->lastInsertId();
				return $this->selectById($insertedId);
			}
		return false;
	}

	public function getValidationErrorsimg($data) {
		$errors = array();
		if(empty($data['path'])) {
			$errors['path'] = 'field path has no value';
		}
		if(empty($data['hash'])) {
			$errors['hash'] = 'field hash has no value';
		}
		return $errors;
	}

	public function getValidationErrors($data) {
		$errors = array();
		if(empty($data['text'])) {
			$errors['text'] = 'field text has no value';
		}
		if(empty($data['title'])) {
			$errors['title'] = 'title text has no value';
		}
		return $errors;
	}

}