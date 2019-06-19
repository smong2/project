<?php
class Service Extends BaseObject
{
	protected $__serviceId;
	protected $__serviceKey;
	protected $__useYN;
	protected $__createD;
	protected $__updateD;


	const USE_Y = 'y';
	const USE_N = 'n';

	public static function instance($pk) /*{{{*/
	{
		static $sInstance = array();

		$pk = strval($pk);

		if (isset($sInstance[$pk]) === false) {
			$className      = __CLASS__;
			$obj            = new $className($pk);
			$sInstance[$pk] = $obj;
		}

		return $sInstance[$pk];
	} /*}}}*/

	protected function __construct($serviceId) /*{{{*/
	{
		$this->__serviceId = $serviceId;
	} /*}}}*/

	/************************************************************************** 
	 ***** ACTION ************************************************************* 
	 **************************************************************************/

	/**
	 * 등록된 계정인지 중복체크
	 */
	public function isDuplicate() /*{{{*/
	{
		$pdo = PDO_Manager::getConnectDB();

		$query = 'SELECT count(*) cnt FROM NC_SERVICE
				  where service_id = :service_id AND 
				  service_key = :service_key';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':service_id',  $this->__serviceId,  PDO::PARAM_STR);
		$stmt->bindValue(':service_key', $this->__serviceKey, PDO::PARAM_STR);
		$stmt->execute();

		$row = $stmt->fetch(PDO::FETCH_ASSOC);

		return ($row['cnt'] == 0 ? false : true);
	} /*}}}*/


	/**
	 * 사용 가능한 계정인지 점검
	 */
	public function isAuth() /*{{{*/
	{
		$pdo = PDO_Manager::getConnectDB();

		$query = 'SELECT count(*) cnt FROM NC_SERVICE
				  where service_id = :service_id AND 
				  service_key = :service_key AND
				  use_yn = :use_yn';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':service_id',  $this->__serviceId,  PDO::PARAM_STR);
		$stmt->bindValue(':service_key', $this->__serviceKey, PDO::PARAM_STR);
		$stmt->bindValue(':use_yn',      self::USE_Y,         PDO::PARAM_STR);
		$stmt->execute();

		$row = $stmt->fetch(PDO::FETCH_ASSOC);

		return ($row['cnt'] == 0 ? false : true);
	} /*}}}*/

	/**
	 * 계정 추가
	 */
	public function add() /*{{{*/
	{
		$pdo = PDO_Manager::getConnectDB();

		$query = 'INSERT INTO NC_SERVICE
				  (service_id, service_key, create_d)
				  VALUES
				  (:service_id, :service_key, getDate())';

		$stmt = $pdo->prepare($query);
		$stmt->bindValue(':service_id',  $this->__serviceId,  PDO::PARAM_STR);
		$stmt->bindValue(':service_key', $this->__serviceKey, PDO::PARAM_STR);
		$stmt->execute();

		return $this;
	} /*}}}*/

	/**
	 * 계정 삭제
	 */
	public function delete() /*{{{*/
	{
		$pdo = PDO_Manager::getConnectDB();

		$query = 'DELETE FROM NC_SERVICE
				  where service_id = :service_id';

		$stmt = $pdo->prepare($query);
		$stmt->bindValue(':service_id', $this->__serviceId, PDO::PARAM_STR);
		$stmt->execute();
	} /*}}}*/

	/**
	 * 사용중으로 업데이트
	 */
	public function updateUseY() /*{{{*/
	{
		$pdo = PDO_Manager::getConnectDB();

		$query = 'UPDATE NC_SERVICE
				  SET use_yn = :use_yn,
					  update_d = getDate()
				  where service_id = :service_id';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':service_id',  $this->__serviceId,  PDO::PARAM_STR);
		$stmt->bindValue(':use_yn',      self::USE_Y,         PDO::PARAM_STR);
		$stmt->execute();
	} /*}}}*/

	/**
	 * 사용안함으로 업데이트
	 */
	public function updateUseN() /*{{{*/
	{
		$pdo = PDO_Manager::getConnectDB();

		$query = 'UPDATE NC_SERVICE
				  SET use_yn = :use_yn,
					  update_d = getDate()
				  where service_id = :service_id';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':service_id',  $this->__serviceId,  PDO::PARAM_STR);
		$stmt->bindValue(':use_yn',      self::USE_N,         PDO::PARAM_STR);
		$stmt->execute();
	} /*}}}*/

	/**
	 * 등록된 계정 가져오기
	 */
	public static function getServices() /*{{{*/
	{
		$pdo = PDO_Manager::getConnectDB();

		$query = 'SELECT * FROM NC_SERVICE';
		$stmt  = $pdo->prepare($query);
		$stmt->execute();


		$services = array();

		while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
			$service = Service::instance($row['service_id']);
			$service->setServiceKey($row['service_key']);
			$service->setUseYN($row['use_yn']);
			$service->setCreateD(strtotime($row['create_d']));
			$service->setUpdateD(strtotime($row['update_d']));

			$services[] = $service;
		}

		return $services;
	} /*}}}*/
}
?>
