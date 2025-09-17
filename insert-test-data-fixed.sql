-- Insert 20 test records with varying day_status values
-- TestDatensatz as owner_name, varying dates and day_status

INSERT INTO reports (
    date, 
    owner_oid, 
    owner_name, 
    customer_no, 
    customer_name, 
    classification, 
    short_report, 
    next_steps, 
    is_new_account, 
    overnight, 
    day_status,
    created_at,
    updated_at
) VALUES 
    ('2025-01-15', 'test001', 'TestDatensatz', 'K1001', 'Testfirma GmbH', 'A', 'Produktpräsentation durchgeführt', 'Großes Interesse zeigen', false, false, 'MOBILE', NOW(), NOW()),
    ('2025-01-15', 'test001', 'TestDatensatz', 'K1002', 'Beispiel AG', 'B', 'Vertragsverhandlung', 'Folgetermin vereinbaren', true, false, 'MOBILE', NOW(), NOW()),
    ('2025-01-16', 'test001', 'TestDatensatz', 'K1003', 'Muster & Co KG', 'C', 'Büroarbeit Angebotsstellung', 'Angebot nachfassen', false, false, 'OFFICE', NOW(), NOW()),
    ('2025-01-16', 'test001', 'TestDatensatz', 'K1004', 'Demo Solutions', 'A', 'Telefonkonferenz', 'Remote Meeting planen', false, false, 'OFFICE', NOW(), NOW()),
    ('2025-01-17', 'test001', 'TestDatensatz', 'K1005', 'Test Industries', 'B', 'Krankheitsbedingt ausgefallen', 'Termin nachholen', false, false, 'PREVENTED', NOW(), NOW()),
    ('2025-01-18', 'test001', 'TestDatensatz', 'K1006', 'Sample Corp', 'C', 'Kundenbesuch vor Ort', 'Produktvorführung folgt', false, true, 'MOBILE', NOW(), NOW()),
    ('2025-01-19', 'test001', 'TestDatensatz', 'K1007', 'Probe GmbH', 'A', 'Messevorbereitung', 'Materialien fertigstellen', false, false, 'OFFICE', NOW(), NOW()),
    ('2025-01-20', 'test001', 'TestDatensatz', 'K1008', 'Versuch AG', 'B', 'Außentermin Süddeutschland', 'Nachbereitung erforderlich', false, true, 'MOBILE', NOW(), NOW()),
    ('2025-01-21', 'test001', 'TestDatensatz', 'K1009', 'Pilot Systems', 'C', 'Urlaub', 'Nach Rückkehr kontaktieren', false, false, 'PREVENTED', NOW(), NOW()),
    ('2025-01-22', 'test001', 'TestDatensatz', 'K1010', 'Trial Tech', 'A', 'Bürotag Kalkulation', 'Preise finalisieren', false, false, 'OFFICE', NOW(), NOW()),
    ('2025-01-23', 'test001', 'TestDatensatz', 'K1011', 'Experiment Ltd', 'B', 'Kundenbesuche Region Nord', 'Termine nacharbeiten', true, false, 'MOBILE', NOW(), NOW()),
    ('2025-01-24', 'test001', 'TestDatensatz', 'K1012', 'Dummy Data AG', 'C', 'Verwaltungsaufgaben', 'Reports vervollständigen', false, false, 'OFFICE', NOW(), NOW()),
    ('2025-01-25', 'test001', 'TestDatensatz', 'K1013', 'Mock Solutions', 'A', 'Fortbildung', 'Gelerntes anwenden', false, false, 'PREVENTED', NOW(), NOW()),
    ('2025-01-26', 'test001', 'TestDatensatz', 'K1014', 'Stub Services', 'B', 'Außendienst Region West', 'Neukundenakquise fortsetzen', true, true, 'MOBILE', NOW(), NOW()),
    ('2025-01-27', 'test001', 'TestDatensatz', 'K1015', 'Placeholder Inc', 'C', 'Büroarbeit Dokumentation', 'CRM aktualisieren', false, false, 'OFFICE', NOW(), NOW()),
    ('2025-01-28', 'test001', 'TestDatensatz', 'K1016', 'Example Enterprise', 'A', 'Großkundentermin', 'Vertragsdetails klären', false, false, 'MOBILE', NOW(), NOW()),
    ('2025-01-29', 'test001', 'TestDatensatz', 'K1017', 'Instance GmbH', 'B', 'Teammeeting', 'Strategie umsetzen', false, false, 'OFFICE', NOW(), NOW()),
    ('2025-01-30', 'test001', 'TestDatensatz', 'K1018', 'Case Study AG', 'C', 'Außentermin abgesagt', 'Neuen Termin vereinbaren', false, false, 'PREVENTED', NOW(), NOW()),
    ('2025-01-31', 'test001', 'TestDatensatz', 'K1019', 'Scenario Systems', 'A', 'Jahresabschluss Vorbereitung', 'Zahlen präsentieren', false, false, 'OFFICE', NOW(), NOW()),
    ('2025-02-01', 'test001', 'TestDatensatz', 'K1020', 'Blueprint Tech', 'B', 'Kundentour Ost', 'Nachfassen bei allen Kunden', false, true, 'MOBILE', NOW(), NOW());