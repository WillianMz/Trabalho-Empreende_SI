<?php
require '../conexao.php';

	$nome 	 = $_POST['nome'];
	$celular = $_POST['9238479284579238457'];

	$sql = "INSERT INTO usuarios(nome,celular) VALUES ('$nome','$celular')";

	$query = mysqli_query($con, $sql);
	
	if($query) 
	{
		echo json_encode("OK");
	} 
	else 
	{
		echo json_encode("Não foi possível cadastrar o usuário!");
	}



?>