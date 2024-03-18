package repositorio;
import java.util.Collection;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import modelo.PuntoFisico;




public interface PuntoFisicoRepository extends JpaRepository<PuntoFisico, Integer>{

        @Modifying
        @Transactional
        @Query(value = "INSERT INTO PuntoFisico (id_puntofisico	,tipo,oficina) VALUES ( bancAndes_seq.nextval , ,:id_puntofisico,:tipo,:oficina)", nativeQuery = true)
        void insertarPuntoFisico(@Param("id_puntfisico") Integer id_puntfisico, @Param("tipo") String tipo, @Param("oficina") String oficina);

     
}