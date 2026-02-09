from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship
from .database import Base

class TenantConfig(Base):
    __tablename__ = 'tenant_configs'

    id = Column(Integer, primary_key=True, index=True)
    tenant_id = Column(Integer, ForeignKey('tenants.id'))
    resolution = Column(String, index=True)
    numbering_range_start = Column(Integer)
    numbering_range_end = Column(Integer)
    tax_types = Column(String)  # JSON string for multiple tax types

    tenant = relationship("Tenant", back_populates="config")