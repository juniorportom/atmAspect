import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import ejemplo.cajero.control.Comando;

public aspect Log {	
		List<String> logEvents = new ArrayList<>();
		Date date = new Date();
		DateFormat hourdateFormat = new SimpleDateFormat("HH:mm:ss dd/MM/yyyy");
	
	  pointcut metodosDelModelo() : call( * ejemplo.cajero.modelo..*(..));
	  
	  
		//ejecución antes de ejecutar el método 
		 before(): metodosDelModelo() {
			 logEvents.add("Fecha: " + hourdateFormat.format(date) + "\t objeto:     : " + thisJoinPoint.getTarget() + "\t método     : " + thisJoinPoint.getSignature() + "\t argumentos : " + thisJoinPoint.getArgs());
		 }
	 
	 
		 
		 pointcut retornarLog() : call( * ejemplo.cajero.Cajero.retornaComandoSeleccionado(..));
		//ejecución al retornar el método
		after() returning(Object resultado): retornarLog() {
			Comando valor = (Comando) resultado;
			if(valor == null) {
				System.out.println("----------------------------- EVENTOS DEL DIA ----------------------");
				for(int i = 0; i < logEvents.size(); i++) {
					System.out.println(logEvents.get(i));
				}
			}		
		}
		
		
}
