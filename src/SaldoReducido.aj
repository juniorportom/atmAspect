import ejemplo.cajero.modelo.Cuenta;

public aspect SaldoReducido {	
	
	Cuenta cuenta;
	pointcut saldoValidar() : call( * ejemplo.cajero.modelo.Banco.buscarCuenta(..));
	
	after() returning(Object resultado): saldoValidar() {
		cuenta = (Cuenta) resultado;	
		 //System.out.println("Saldo disponible a validar para bloqueo: " + cuenta.getSaldo());
	}
	
	
	pointcut retirarControl(long valor) : call( * ejemplo.cajero.modelo.Cuenta.retirar(..)) && args(valor);
	
	Object around(long valor) throws Exception : retirarControl(valor) {
		//System.out.println("Ingreso al metodo sin saldo!!: " + cuenta.getSaldo());
		if (cuenta.getSaldo() - valor >= 200){
			//System.out.println("Ingreso al metodo!!: " + cuenta.getSaldo());
			 proceed(valor);
			 
		}else {
			//System.out.println("No se puede tener menos de 200 de saldo!!");
			throw new Exception("No se puede tener menos de 200 de saldo!!, Saldo actual: " + cuenta.getSaldo() + " valor solicitado: " + valor );
		}
		return 0;
		
	}
	
	
}
