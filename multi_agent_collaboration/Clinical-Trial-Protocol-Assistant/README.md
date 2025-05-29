# Clinical Trial Protocol Assistant

## Overview

This supervisor agent helps researchers and clinical teams develop comprehensive, scientifically sound, and regulatory-compliant clinical trial protocols for pharmaceutical, biotechnology, and medical device studies.

The Clinical Trial Protocol Assistant coordinates two specialized sub-agents:
1. **CLINICAL_SEARCH_AGENT**: Retrieves scientific publications, clinical research, treatment guidelines, and regulatory information
2. **CLINICAL_TRIAL_PROTOCOL_GENERATOR_AGENT**: Generates comprehensive clinical trial protocols based on search results

## Deployment

1. Deploy the required sub-agents according to the instructions in each agent's respective README.md file.

2. Run the deployment script:

```bash
python deploy.py \
  --region <REGION> \
  --stack-name <STACK_NAME> \
  --clinical-search-agent-alias-arn <CLINICAL_SEARCH_AGENT_ALIAS_ARN> \
  --clinical-trial-protocol-generator-agent-alias-arn <CLINICAL_TRIAL_PROTOCOL_GENERATOR_AGENT_ALIAS_ARN>
```

## Example Usage

**Question**: Can you help me develop a Phase II clinical trial protocol for a novel PARP inhibitor in patients with BRCA-mutated ovarian cancer?

**Answer**:

I'll help you develop a Phase II clinical trial protocol for your novel PARP inhibitor in BRCA-mutated ovarian cancer patients. Let me gather the necessary information from scientific literature, regulatory guidelines, and similar clinical trials.

### PROTOCOL SYNOPSIS

**Title**: A Phase II, Randomized, Open-Label Study of [Novel PARP Inhibitor] versus Physician's Choice Chemotherapy in Patients with BRCA-Mutated, Platinum-Resistant Ovarian Cancer

**Primary Objective**: To evaluate the efficacy of [Novel PARP Inhibitor] compared to standard chemotherapy in patients with BRCA-mutated, platinum-resistant ovarian cancer as measured by progression-free survival (PFS).

**Study Design**: Randomized, open-label, multicenter, phase II study with 2:1 randomization to [Novel PARP Inhibitor] or physician's choice chemotherapy.

**Patient Population**: Adult patients with BRCA1/2-mutated (germline or somatic), platinum-resistant epithelial ovarian, fallopian tube, or primary peritoneal cancer.

**Sample Size**: 120 patients (80 in experimental arm, 40 in control arm)

**Treatment Duration**: Until disease progression, unacceptable toxicity, or withdrawal of consent

**Primary Endpoint**: Progression-free survival (PFS) per RECIST v1.1

**Key Secondary Endpoints**:
- Overall response rate (ORR)
- Overall survival (OS)
- Safety and tolerability
- Patient-reported outcomes (PROs)

### BACKGROUND AND RATIONALE

Recent literature shows PARP inhibitors have demonstrated significant clinical benefit in BRCA-mutated ovarian cancer by exploiting synthetic lethality. The FDA has approved several PARP inhibitors for maintenance treatment in platinum-sensitive disease, but options remain limited for platinum-resistant patients.

Regulatory guidance from both FDA and EMA supports accelerated approval pathways for therapies showing meaningful improvement in PFS in this high-unmet-need population.

Similar trials have shown response rates of 30-40% for PARP inhibitors in this population compared to 10-15% for standard chemotherapy, supporting our 2:1 randomization design to maximize patient access to the experimental treatment.

[The response continues with detailed protocol sections...]

## License

This project is licensed under the MIT License. The open-source packages used in this project are under these [licenses](https://sagemaker-solutions-prod-us-east-2.s3-us-east-2.amazonaws.com/sagemaker-lung-cancer-survival-prediction/1.0.0/LICENSE.txt).
