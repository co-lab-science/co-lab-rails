# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
User.destroy_all

User.create([
  {id: 1, name: "Luke Demarest", email: "test", password: "test", admin: true}
])

Lab.destroy_all

Lab.create ([
  {
    user_id: 1,
    title: "85% of all biomedical research funding is wasted",
    body: "According to Chalmers and Glasziou’s 2009 article 'Avoidable waste in the production and reporting of research evidence': more than 85% of global biomedical research funding is wasted. "
  }
])

Question.destroy_all

Question.create([
  {
    user_id: 1,
    lab_id: 1,
    title: "What is the most effective strategy to increase the efficiency of biomedical research spending?",
    body: "What is the most effective strategy to increase the efficiency of biomedical research spending?"
  },
  {
    user_id: 1,
    lab_id: 1,
    title: "What is the purpose of a seed file anyways?",
    body: "What is the most effective strategy to increase the efficiency of biomedical research spending?"
  },
  {
    user_id: 1,
    lab_id: 1,
    title: "why would we find a purpose of a seed file anyways?",
    body: "John McCain"
  },
  {
    user_id: 1,
    lab_id: 1,
    title: "How does one separate truth from lies?",
    body: "John McCain"
  },
  {
    user_id: 1,
    lab_id: 1,
    title: "What is the most effective strategy adfasdfasdfa?",
    body: "What is the most effective strategy to increase the efficiency of biomedical research spending?"
  },
  {
    user_id: 1,
    lab_id: 1,
    title: "Wadfads biomedical research spending?",
    body: "What is the most effective strategy to increase the efficiency of biomedical research spending?"
  },
  {
    user_id: 1,
    lab_id: 5,
    title: "effective strategy adfasdfasdfa?",
    body: "What is the most effective strategy to increase the efficiency of biomedical research spending?"
  },
  {
    user_id: 1,
    lab_id: 5,
    title: "adfasdfasdfa?",
    body: "What is the most effective strategy to increase the efficiency of biomedical research spending?"
  },
])

Hypothesis.destroy_all
Hypothesis.create([
  {
    user_id: 1,
    lab_id: 1,
    title: "Crowd-Sourced Scientific Method: A community designed to maximize the efficiency of research spending",
    body: "According to Chalmers and Glaziou over 85% of global biomedical research spending is wasted, approximately $200 billion annually. These authors publish a series of papers in The Lancet breaking-down this substantial figure into sources of waste scientists find themselves all too familiar with. At Co-Lab, we believe these sources of waste are downstream effects of the traditional grant-based scientific economy. Grants result in perverse incentives for researchers that reduce the quality of research and efficiency of the scientific spending in the modern era of the internet. \n\tCo-Lab leverages the internet to provide an incentive structure that maximizes the efficiency of scientific spending. We host an open database of experimental data from which any user can observe, question, hypothesize, or criticize. We rank users based on the impact of their contributions to science, and financially compensate them accordingly. Most importantly, all of the content created on Co-Lab will be free to access for all. This results in a scientific economy that is inherently collaborative and will maximize the efficiency of scientific spending and the output of the scientific economy."
  },
  {
    user_id: 1,
    lab_id: 1,
    title: "A community designed to maximize the efficiency of research spending",
    body: "According to Chalmers and Glaziou over 85% of global biomedical research spending is wasted, approximately $200 billion annually. These authors publish a series of papers in The Lancet breaking-down this substantial figure into sources of waste scientists find themselves all too familiar with. At Co-Lab, we believe these sources of waste are downstream effects of the traditional grant-based scientific economy. Grants result in perverse incentives for researchers that reduce the quality of research and efficiency of the scientific spending in the modern era of the internet. \n\tCo-Lab leverages the internet to provide an incentive structure that maximizes the efficiency of scientific spending. We host an open database of experimental data from which any user can observe, question, hypothesize, or criticize. We rank users based on the impact of their contributions to science, and financially compensate them accordingly. Most importantly, all of the content created on Co-Lab will be free to access for all. This results in a scientific economy that is inherently collaborative and will maximize the efficiency of scientific spending and the output of the scientific economy."
  },
  {
    user_id: 1,
    lab_id: 1,
    title: "the efficiency of research spending",
    body: "According to Chalmers and Glaziou over 85% of global biomedical research spending is wasted, approximately $200 billion annually. These authors publish a series of papers in The Lancet breaking-down this substantial figure into sources of waste scientists find themselves all too familiar with. At Co-Lab, we believe these sources of waste are downstream effects of the traditional grant-based scientific economy. Grants result in perverse incentives for researchers that reduce the quality of research and efficiency of the scientific spending in the modern era of the internet. \n\tCo-Lab leverages the internet to provide an incentive structure that maximizes the efficiency of scientific spending. We host an open database of experimental data from which any user can observe, question, hypothesize, or criticize. We rank users based on the impact of their contributions to science, and financially compensate them accordingly. Most importantly, all of the content created on Co-Lab will be free to access for all. This results in a scientific economy that is inherently collaborative and will maximize the efficiency of scientific spending and the output of the scientific economy."
  },
  {
    user_id: 1,
    lab_id: 1,
    title: "Research spending",
    body: "According to Chalmers and Glaziou over 85% of global biomedical research spending is wasted, approximately $200 billion annually. These authors publish a series of papers in The Lancet breaking-down this substantial figure into sources of waste scientists find themselves all too familiar with. At Co-Lab, we believe these sources of waste are downstream effects of the traditional grant-based scientific economy. Grants result in perverse incentives for researchers that reduce the quality of research and efficiency of the scientific spending in the modern era of the internet. \n\tCo-Lab leverages the internet to provide an incentive structure that maximizes the efficiency of scientific spending. We host an open database of experimental data from which any user can observe, question, hypothesize, or criticize. We rank users based on the impact of their contributions to science, and financially compensate them accordingly. Most importantly, all of the content created on Co-Lab will be free to access for all. This results in a scientific economy that is inherently collaborative and will maximize the efficiency of scientific spending and the output of the scientific economy."
  }
])


Tag.destroy_all
Tag.create([
  { lab_id: 1, name: "Biochemistry"},
  { name: "Cell Biology" },
  { name: "Molecular Biology" },
  { name: "Developmental and Reproductive Biology" },
  { name: "Immunology" },
  { name: "Bioinformatics" },
  { name: "Oncology" },
  { name: "Cell and Nuclear Division" },
  { name: "Computational Biology" },
  { name: "Epigenetics" },
  { name: "Enzymes" },
  { name: "Genetics" },
  { name: "Genomics" },
  { name: "Transcriptomics" },
  { name: "Proteomics" },
  { name: "Pharmacology" },
  { name: "Pathology" },
  { name: "Population, Ecological, and Evolutionary Genetics" },
  { name: "Receptors and Membrane Biology" },
  { name: "Synthetic Biology" },
  { lab_id: 1, name: "Systems Biology" },
  { name: "Toxicology" },
  { name: "Virology" },
  { name: "Biological Techniques" },
  { lab_id: 1, name: "Co-Lab" }
])


