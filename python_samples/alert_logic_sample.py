"""
Sanitized sample logic for a crypto risk alert concept.

No real API keys, account data, private keys, or live trading code are included.

Purpose:
- Detect simple price drop / volume spike conditions
- Generate a user-facing risk alert message
- Show how market signals can be converted into risk alerts
"""

from dataclasses import dataclass


@dataclass
class MarketSnapshot:
    asset_symbol: str
    price_change_pct: float
    volume_change_pct: float
    event_note: str = ""


def classify_risk(snapshot: MarketSnapshot) -> str:
    """
    Simple risk classification logic for portfolio demonstration.
    This is not an investment recommendation model.
    """

    if snapshot.price_change_pct <= -5 and snapshot.volume_change_pct >= 100:
        return "HIGH"

    if snapshot.price_change_pct <= -3 or snapshot.volume_change_pct >= 70:
        return "MEDIUM"

    return "LOW"


def build_alert_message(snapshot: MarketSnapshot) -> str:
    risk_level = classify_risk(snapshot)

    return (
        f"[{snapshot.asset_symbol}] Risk Alert\n"
        f"- Risk Level: {risk_level}\n"
        f"- Price Change: {snapshot.price_change_pct:.2f}%\n"
        f"- Volume Change: {snapshot.volume_change_pct:.2f}%\n"
        f"- Note: {snapshot.event_note or 'No major event note'}\n"
        f"This message is for information only and should not be interpreted as investment advice."
    )


if __name__ == "__main__":
    sample = MarketSnapshot(
        asset_symbol="BTC",
        price_change_pct=-5.2,
        volume_change_pct=145.0,
        event_note="Price drop with volume spike",
    )

    print(build_alert_message(sample))
