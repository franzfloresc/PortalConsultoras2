GO
delete PWD
from PedidoWebDetalle PWD
inner join PedidoWeb PW on PWD.CampaniaId = PW.CampaniaID and PWD.ConsultoraID = PW.ConsultoraID
inner join PedidoRecuperacion PR on PWD.CampaniaId = PR.CampaniaID and PWD.ConsultoraID = PR.ConsultoraID
where PW.IPUsuario is null;

delete PW
from PedidoWeb PW
inner join PedidoRecuperacion PR on PW.CampaniaId = PR.CampaniaID and PW.ConsultoraID = PR.ConsultoraID
where PW.IPUsuario is null;
GO