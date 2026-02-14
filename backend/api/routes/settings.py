from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from ..models import TenantConfig
from ..database import get_db

router = APIRouter()

@router.put("/settings/fiscal")
async def update_fiscal_settings(tenant_id: int, resolution: str, numbering_range_start: int, numbering_range_end: int, tax_types: str, db: Session = Depends(get_db)):
    config = db.query(TenantConfig).filter(TenantConfig.tenant_id == tenant_id).first()
    if not config:
        raise HTTPException(status_code=404, detail="Config not found")
    config.resolution = resolution
    config.numbering_range_start = numbering_range_start
    config.numbering_range_end = numbering_range_end
    config.tax_types = tax_types
    db.commit()
    return {"msg": "Fiscal settings updated"}