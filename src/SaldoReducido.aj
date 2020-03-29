import ejemplo.cajero.modelo.Cuenta;

public aspect SaldoReducido {	
	
	Cuenta cuenta;
	pointcut saldoValidar() : call( * ejemplo.cajero.modelo.Banco.buscarCuenta(..));
	
	after() returning(Object resultado): saldoValidar() {
		cuenta = (Cuenta) resultado;	
		 //System.out.println("Saldo disponible a validar para bloqueo: " + cuenta.getSaldo());
	}
	
	
	pointcut retirarControl() : call( * ejemplo.cajero.modelo.Cuenta.retirar(..));
	
	Object around() throws Exception : retirarControl() {
		//System.out.println("Ingreso al metodo sin saldo!!: " + cuenta.getSaldo());
		if (cuenta.getSaldo() > 200){
			//System.out.println("Ingreso al metodo!!: " + cuenta.getSaldo());
			 proceed();
			 
		}else {
			//System.out.println("No se puede tener menos de 200 de saldo!!");
			throw new Exception("No se puede tener menos de 200 de saldo!!");
		}
		return 0;
		
	}
	
	
}
