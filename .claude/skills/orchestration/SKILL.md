---
name: orchestration
description: Agent orchestration routing table and delegation patterns. Use this skill when deciding which specialist agent to invoke, how to decompose multi-agent tasks, or how to coordinate parallel work across divisions.
---

# Agent Orchestration

## When to Delegate

**Delegate to specialists when:**
- Task requires deep domain expertise
- Task has discrete phases (research → implement → review → test)
- Multiple independent subtasks can run in parallel
- Task is outside your core competency

**Handle yourself when:**
- Task is trivial (< 3 steps, conversational)
- Task is purely informational

## Division Team Leads

| Task Type | Use |
|-----------|-----|
| Implement code / architecture / DevOps | @team-engineering |
| UI/UX design, brand, accessibility | @team-design |
| Testing, QA, performance | @team-qa |
| Product management, prioritization | @team-product |
| Project planning, coordination | @team-project-mgmt |
| Marketing, content, SEO | @team-marketing |
| Sales, deals, pipeline | @team-sales |
| Paid ads, campaigns | @team-paid-media |
| Game development | @team-game-dev |
| AR/VR/XR, visionOS | @team-spatial |
| MCP, AI/ML, blockchain, docs | @team-specialized |

## Delegation Patterns

Sequential: `architect → developer → reviewer → tester`
Parallel: `frontend-developer + backend-architect (simultaneously)`
Research first: `codebase-explorer → specialist → reality-checker`

## Full Routing Table (141 agents)

**Engineering (@team-engineering):**
- @agency-ai-data-remediation-engineer — "Specialist in self-healing data pipelines — uses air-gapped local SLMs and semantic clustering to automatically detect, classify, and fix data anomalies at scale. Focuses exclusively on the remediation layer: intercepting bad data, generating deterministic fix logic via Ollama, and guaranteeing zero data loss. Not a general data engineer — a surgical specialist for when your data is broken and the pipeline can't stop."
- @agency-ai-engineer — Expert AI/ML engineer specializing in machine learning model development, deployment, and integration into production systems. Focused on building intelligent features, data pipelines, and AI-powered applications with emphasis on practical, scalable solutions.
- @agency-autonomous-optimization-architect — Intelligent system governor that continuously shadow-tests APIs for performance while enforcing strict financial and security guardrails against runaway costs.
- @agency-backend-architect — Senior backend architect specializing in scalable system design, database architecture, API development, and cloud infrastructure. Builds robust, secure, performant server-side applications and microservices
- @agency-code-reviewer — Expert code reviewer who provides constructive, actionable feedback focused on correctness, maintainability, security, and performance — not style preferences.
- @agency-database-optimizer — Expert database specialist focusing on schema design, query optimization, indexing strategies, and performance tuning for PostgreSQL, MySQL, and modern databases like Supabase and PlanetScale.
- @agency-data-engineer — Expert data engineer specializing in building reliable data pipelines, lakehouse architectures, and scalable data infrastructure. Masters ETL/ELT, Apache Spark, dbt, streaming systems, and cloud data platforms to turn raw data into trusted, analytics-ready assets.
- @agency-devops-automator — Expert DevOps engineer specializing in infrastructure automation, CI/CD pipeline development, and cloud operations
- @agency-embedded-firmware-engineer — Specialist in bare-metal and RTOS firmware - ESP32/ESP-IDF, PlatformIO, Arduino, ARM Cortex-M, STM32 HAL/LL, Nordic nRF5/nRF Connect SDK, FreeRTOS, Zephyr
- @agency-feishu-integration-developer — Full-stack integration expert specializing in the Feishu (Lark) Open Platform — proficient in Feishu bots, mini programs, approval workflows, Bitable (multidimensional spreadsheets), interactive message cards, Webhooks, SSO authentication, and workflow automation, building enterprise-grade collaboration and automation solutions within the Feishu ecosystem.
- @agency-frontend-developer — Expert frontend developer specializing in modern web technologies, React/Vue/Angular frameworks, UI implementation, and performance optimization
- @agency-git-workflow-master — Expert in Git workflows, branching strategies, and version control best practices including conventional commits, rebasing, worktrees, and CI-friendly branch management.
- @agency-incident-response-commander — Expert incident commander specializing in production incident management, structured response coordination, post-mortem facilitation, SLO/SLI tracking, and on-call process design for reliable engineering organizations.
- @agency-mobile-app-builder — Specialized mobile application developer with expertise in native iOS/Android development and cross-platform frameworks
- @agency-rapid-prototyper — Specialized in ultra-fast proof-of-concept development and MVP creation using efficient tools and frameworks
- @agency-security-engineer — Expert application security engineer specializing in threat modeling, vulnerability assessment, secure code review, and security architecture design for modern web and cloud-native applications.
- @agency-senior-developer — Premium implementation specialist - Masters Laravel/Livewire/FluxUI, advanced CSS, Three.js integration
- @agency-software-architect — Expert software architect specializing in system design, domain-driven design, architectural patterns, and technical decision-making for scalable, maintainable systems.
- @agency-solidity-smart-contract-engineer — Expert Solidity developer specializing in EVM smart contract architecture, gas optimization, upgradeable proxy patterns, DeFi protocol development, and security-first contract design across Ethereum and L2 chains.
- @agency-sre-site-reliability-engineer — Expert site reliability engineer specializing in SLOs, error budgets, observability, chaos engineering, and toil reduction for production systems at scale.
- @agency-technical-writer — Expert technical writer specializing in developer documentation, API references, README files, and tutorials. Transforms complex engineering concepts into clear, accurate, and engaging docs that developers actually read and use.
- @agency-threat-detection-engineer — Expert detection engineer specializing in SIEM rule development, MITRE ATT&CK coverage mapping, threat hunting, alert tuning, and detection-as-code pipelines for security operations teams.
- @agency-wechat-mini-program-developer — Expert WeChat Mini Program developer specializing in 小程序 development with WXML/WXSS/WXS, WeChat API integration, payment systems, subscription messaging, and the full WeChat ecosystem.
- @agency-codebase-explorer — Expert codebase and web research specialist that explores project structure, maps architecture, finds code patterns, and researches external documentation — zero file modifications.
- @agency-debugger — Expert debugging specialist that diagnoses errors, analyzes stack traces, identifies root causes, and provides precise fix recommendations — without modifying any files.
- @agency-dependency-auditor — Expert package management specialist that audits npm/bun dependencies for vulnerabilities, outdated versions, and license issues — always asks before installing or removing anything.
- @agency-github-code-searcher — Expert GitHub code search specialist that finds real-world implementation examples, patterns, and known exploits across public repositories using gh_grep — zero file modifications.

**Design (@team-design):**
- @agency-brand-guardian — Expert brand strategist and guardian specializing in brand identity development, consistency maintenance, and strategic brand positioning
- @agency-image-prompt-engineer — Expert photography prompt engineer specializing in crafting detailed, evocative prompts for AI image generation. Masters the art of translating visual concepts into precise language that produces stunning, professional-quality photography through generative AI tools.
- @agency-inclusive-visuals-specialist — Representation expert who defeats systemic AI biases to generate culturally accurate, affirming, and non-stereotypical images and video.
- @agency-ui-designer — Expert UI designer specializing in visual design systems, component libraries, and pixel-perfect interface creation. Creates beautiful, consistent, accessible user interfaces that enhance UX and reflect brand identity
- @agency-ux-architect — Technical architecture and UX specialist who provides developers with solid foundations, CSS systems, and clear implementation guidance
- @agency-ux-researcher — Expert user experience researcher specializing in user behavior analysis, usability testing, and data-driven design insights. Provides actionable research findings that improve product usability and user satisfaction
- @agency-visual-storyteller — Expert visual communication specialist focused on creating compelling visual narratives, multimedia content, and brand storytelling through design. Specializes in transforming complex information into engaging visual stories that connect with audiences and drive emotional engagement.
- @agency-whimsy-injector — Expert creative specialist focused on adding personality, delight, and playful elements to brand experiences. Creates memorable, joyful interactions that differentiate brands through unexpected moments of whimsy

**QA & Testing (@team-qa):**
- @agency-accessibility-auditor — Expert accessibility specialist who audits interfaces against WCAG standards, tests with assistive technologies, and ensures inclusive design. Defaults to finding barriers — if it's not tested with a screen reader, it's not accessible.
- @agency-api-tester — Expert API testing specialist focused on comprehensive API validation, performance testing, and quality assurance across all systems and third-party integrations
- @agency-evidence-collector — Screenshot-obsessed, fantasy-allergic QA specialist - Default to finding 3-5 issues, requires visual proof for everything
- @agency-performance-benchmarker — Expert performance testing and optimization specialist focused on measuring, analyzing, and improving system performance across all applications and infrastructure
- @agency-reality-checker — Stops fantasy approvals, evidence-based certification - Default to "NEEDS WORK", requires overwhelming proof for production readiness
- @agency-test-results-analyzer — Expert test analysis specialist focused on comprehensive test result evaluation, quality metrics analysis, and actionable insight generation from testing activities
- @agency-tool-evaluator — Expert technology assessment specialist focused on evaluating, testing, and recommending tools, software, and platforms for business use and productivity optimization
- @agency-workflow-optimizer — Expert process improvement specialist focused on analyzing, optimizing, and automating workflows across all business functions for maximum productivity and efficiency
- @agency-test-runner — Expert test execution specialist that runs test suites, analyzes failures, identifies flaky tests, and reports which tests fail and why — without modifying test code.

**Product (@team-product):**
- @agency-behavioral-nudge-engine — Behavioral psychology specialist that adapts software interaction cadences and styles to maximize user motivation and success.
- @agency-feedback-synthesizer — Expert in collecting, analyzing, and synthesizing user feedback from multiple channels to extract actionable product insights. Transforms qualitative feedback into quantitative priorities and strategic recommendations.
- @agency-product-manager — Holistic product leader who owns the full product lifecycle — from discovery and strategy through roadmap, stakeholder alignment, go-to-market, and outcome measurement. Bridges business goals, user needs, and technical reality to ship the right thing at the right time.
- @agency-sprint-prioritizer — Expert product manager specializing in agile sprint planning, feature prioritization, and resource allocation. Focused on maximizing team velocity and business value delivery through data-driven prioritization frameworks.
- @agency-trend-researcher — Expert market intelligence analyst specializing in identifying emerging trends, competitive analysis, and opportunity assessment. Focused on providing actionable insights that drive product strategy and innovation decisions.

**Project Management (@team-project-mgmt):**
- @agency-experiment-tracker — Expert project manager specializing in experiment design, execution tracking, and data-driven decision making. Focused on managing A/B tests, feature experiments, and hypothesis validation through systematic experimentation and rigorous analysis.
- @agency-jira-workflow-steward — Expert delivery operations specialist who enforces Jira-linked Git workflows, traceable commits, structured pull requests, and release-safe branch strategy across software teams.
- @agency-project-shepherd — Expert project manager specializing in cross-functional project coordination, timeline management, and stakeholder alignment. Focused on shepherding projects from conception to completion while managing resources, risks, and communications across multiple teams and departments.
- @agency-studio-operations — Expert operations manager specializing in day-to-day studio efficiency, process optimization, and resource coordination. Focused on ensuring smooth operations, maintaining productivity standards, and supporting all teams with the tools and processes needed for success.
- @agency-studio-producer — Senior strategic leader specializing in high-level creative and technical project orchestration, resource allocation, and multi-project portfolio management. Focused on aligning creative vision with business objectives while managing complex cross-functional initiatives and ensuring optimal studio operations.
- @agency-senior-project-manager — Converts specs to tasks and remembers previous projects. Focused on realistic scope, no background processes, exact spec requirements

**Marketing (@team-marketing):**
- @agency-ai-citation-strategist — Expert in AI recommendation engine optimization (AEO/GEO) — audits brand visibility across ChatGPT, Claude, Gemini, and Perplexity, identifies why competitors get cited instead, and delivers content fixes that improve AI citations
- @agency-app-store-optimizer — Expert app store marketing specialist focused on App Store Optimization (ASO), conversion rate optimization, and app discoverability
- @agency-baidu-seo-specialist — Expert Baidu search optimization specialist focused on Chinese search engine ranking, Baidu ecosystem integration, ICP compliance, Chinese keyword research, and mobile-first indexing for the China market.
- @agency-bilibili-content-strategist — Expert Bilibili marketing specialist focused on UP主 growth, danmaku culture mastery, B站 algorithm optimization, community building, and branded content strategy for China's leading video community platform.
- @agency-book-co-author — Strategic thought-leadership book collaborator for founders, experts, and operators turning voice notes, fragments, and positioning into structured first-person chapters.
- @agency-carousel-growth-engine — Autonomous TikTok and Instagram carousel generation specialist. Analyzes any website URL with Playwright, generates viral 6-slide carousels via Gemini image generation, publishes directly to feed via Upload-Post API with auto trending music, fetches analytics, and iteratively improves through a data-driven learning loop.
- @agency-china-e-commerce-operator — Expert China e-commerce operations specialist covering Taobao, Tmall, Pinduoduo, and JD ecosystems with deep expertise in product listing optimization, live commerce, store operations, 618/Double 11 campaigns, and cross-platform strategy.
- @agency-content-creator — Expert content strategist and creator for multi-platform campaigns. Develops editorial calendars, creates compelling copy, manages brand storytelling, and optimizes content for engagement across all digital channels.
- @agency-cross-border-e-commerce-specialist — Full-funnel cross-border e-commerce strategist covering Amazon, Shopee, Lazada, AliExpress, Temu, and TikTok Shop operations, international logistics and overseas warehousing, compliance and taxation, multilingual listing optimization, brand globalization, and DTC independent site development.
- @agency-douyin-strategist — Short-video marketing expert specializing in the Douyin platform, with deep expertise in recommendation algorithm mechanics, viral video planning, livestream commerce workflows, and full-funnel brand growth through content matrix strategies.
- @agency-growth-hacker — Expert growth strategist specializing in rapid user acquisition through data-driven experimentation. Develops viral loops, optimizes conversion funnels, and finds scalable growth channels for exponential business growth.
- @agency-instagram-curator — Expert Instagram marketing specialist focused on visual storytelling, community building, and multi-format content optimization. Masters aesthetic development and drives meaningful engagement.
- @agency-kuaishou-strategist — Expert Kuaishou marketing strategist specializing in short-video content for China's lower-tier city markets, live commerce operations, community trust building, and grassroots audience growth on 快手.
- @agency-linkedin-content-creator — Expert LinkedIn content strategist focused on thought leadership, personal brand building, and high-engagement professional content. Masters LinkedIn's algorithm and culture to drive inbound opportunities for founders, job seekers, developers, and anyone building a professional presence.
- @agency-livestream-commerce-coach — Veteran livestream e-commerce coach specializing in host training and live room operations across Douyin, Kuaishou, Taobao Live, and Channels, covering script design, product sequencing, paid-vs-organic traffic balancing, conversion closing techniques, and real-time data-driven optimization.
- @agency-podcast-strategist — Content strategy and operations expert for the Chinese podcast market, with deep expertise in Xiaoyuzhou, Ximalaya, and other major audio platforms, covering show positioning, audio production, audience growth, multi-platform distribution, and monetization to help podcast creators build sticky audio content brands.
- @agency-private-domain-operator — Expert in building enterprise WeChat (WeCom) private domain ecosystems, with deep expertise in SCRM systems, segmented community operations, Mini Program commerce integration, user lifecycle management, and full-funnel conversion optimization.
- @agency-reddit-community-builder — Expert Reddit marketing specialist focused on authentic community engagement, value-driven content creation, and long-term relationship building. Masters Reddit culture navigation.
- @agency-seo-specialist — Expert search engine optimization strategist specializing in technical SEO, content optimization, link authority building, and organic search growth. Drives sustainable traffic through data-driven search strategies.
- @agency-short-video-editing-coach — Hands-on short-video editing coach covering the full post-production pipeline, with mastery of CapCut Pro, Premiere Pro, DaVinci Resolve, and Final Cut Pro across composition and camera language, color grading, audio engineering, motion graphics and VFX, subtitle design, multi-platform export optimization, editing workflow efficiency, and AI-assisted editing.
- @agency-social-media-strategist — Expert social media strategist for LinkedIn, Twitter, and professional platforms. Creates cross-platform campaigns, builds communities, manages real-time engagement, and develops thought leadership strategies.
- @agency-tiktok-strategist — Expert TikTok marketing specialist focused on viral content creation, algorithm optimization, and community building. Masters TikTok's unique culture and features for brand growth.
- @agency-twitter-engager — Expert Twitter marketing specialist focused on real-time engagement, thought leadership building, and community-driven growth. Builds brand authority through authentic conversation participation and viral thread creation.
- @agency-wechat-official-account-manager — Expert WeChat Official Account (OA) strategist specializing in content marketing, subscriber engagement, and conversion optimization. Masters multi-format content and builds loyal communities through consistent value delivery.
- @agency-weibo-strategist — Full-spectrum operations expert for Sina Weibo, with deep expertise in trending topic mechanics, Super Topic community management, public sentiment monitoring, fan economy strategies, and Weibo advertising, helping brands achieve viral reach and sustained growth on China's leading public discourse platform.
- @agency-xiaohongshu-specialist — Expert Xiaohongshu marketing specialist focused on lifestyle content, trend-driven strategies, and authentic community engagement. Masters micro-content creation and drives viral growth through aesthetic storytelling.
- @agency-zhihu-strategist — Expert Zhihu marketing specialist focused on thought leadership, community credibility, and knowledge-driven engagement. Masters question-answering strategy and builds brand authority through authentic expertise sharing.

**Sales (@team-sales):**
- @agency-account-strategist — Expert post-sale account strategist specializing in land-and-expand execution, stakeholder mapping, QBR facilitation, and net revenue retention. Turns closed deals into long-term platform relationships through systematic expansion planning and multi-threaded account development.
- @agency-sales-coach — Expert sales coaching specialist focused on rep development, pipeline review facilitation, call coaching, deal strategy, and forecast accuracy. Makes every rep and every deal better through structured coaching methodology and behavioral feedback.
- @agency-deal-strategist — Senior deal strategist specializing in MEDDPICC qualification, competitive positioning, and win planning for complex B2B sales cycles. Scores opportunities, exposes pipeline risk, and builds deal strategies that survive forecast review.
- @agency-discovery-coach — Coaches sales teams on elite discovery methodology — question design, current-state mapping, gap quantification, and call structure that surfaces real buying motivation.
- @agency-sales-engineer — Senior pre-sales engineer specializing in technical discovery, demo engineering, POC scoping, competitive battlecards, and bridging product capabilities to business outcomes. Wins the technical decision so the deal can close.
- @agency-outbound-strategist — Signal-based outbound specialist who designs multi-channel prospecting sequences, defines ICPs, and builds pipeline through research-driven personalization — not volume.
- @agency-pipeline-analyst — Revenue operations analyst specializing in pipeline health diagnostics, deal velocity analysis, forecast accuracy, and data-driven sales coaching. Turns CRM data into actionable pipeline intelligence that surfaces risks before they become missed quarters.
- @agency-proposal-strategist — Strategic proposal architect who transforms RFPs and sales opportunities into compelling win narratives. Specializes in win theme development, competitive positioning, executive summary craft, and building proposals that persuade rather than merely comply.

**Paid Media (@team-paid-media):**
- @agency-paid-media-auditor — Comprehensive paid media auditor who systematically evaluates Google Ads, Microsoft Ads, and Meta accounts across 200+ checkpoints spanning account structure, tracking, bidding, creative, audiences, and competitive positioning. Produces actionable audit reports with prioritized recommendations and projected impact.
- @agency-ad-creative-strategist — Paid media creative specialist focused on ad copywriting, RSA optimization, asset group design, and creative testing frameworks across Google, Meta, Microsoft, and programmatic platforms. Bridges the gap between performance data and persuasive messaging.
- @agency-paid-social-strategist — Cross-platform paid social advertising specialist covering Meta (Facebook/Instagram), LinkedIn, TikTok, Pinterest, X, and Snapchat. Designs full-funnel social ad programs from prospecting through retargeting with platform-specific creative and audience strategies.
- @agency-ppc-campaign-strategist — Senior paid media strategist specializing in large-scale search, shopping, and performance max campaign architecture across Google, Microsoft, and Amazon ad platforms. Designs account structures, budget allocation frameworks, and bidding strategies that scale from $10K to $10M+ monthly spend.
- @agency-programmatic-display-buyer — Display advertising and programmatic media buying specialist covering managed placements, Google Display Network, DV360, trade desk platforms, partner media (newsletters, sponsored content), and ABM display strategies via platforms like Demandbase and 6Sense.
- @agency-search-query-analyst — Specialist in search term analysis, negative keyword architecture, and query-to-intent mapping. Turns raw search query data into actionable optimizations that eliminate waste and amplify high-intent traffic across paid search accounts.
- @agency-tracking-measurement-specialist — Expert in conversion tracking architecture, tag management, and attribution modeling across Google Tag Manager, GA4, Google Ads, Meta CAPI, LinkedIn Insight Tag, and server-side implementations. Ensures every conversion is counted correctly and every dollar of ad spend is measurable.

**Game Development (@team-game-dev):**
- @agency-game-audio-engineer — Interactive audio specialist - Masters FMOD/Wwise integration, adaptive music systems, spatial audio, and audio performance budgeting across all game engines
- @agency-game-designer — Systems and mechanics architect - Masters GDD authorship, player psychology, economy balancing, and gameplay loop design across all engines and genres
- @agency-level-designer — Spatial storytelling and flow specialist - Masters layout theory, pacing architecture, encounter design, and environmental narrative across all game engines
- @agency-narrative-designer — Story systems and dialogue architect - Masters GDD-aligned narrative design, branching dialogue, lore architecture, and environmental storytelling across all game engines
- @agency-technical-artist — Art-to-engine pipeline specialist - Masters shaders, VFX systems, LOD pipelines, performance budgeting, and cross-engine asset optimization

**Spatial Computing (@team-spatial):**
- @agency-macos-spatial-metal-engineer — Native Swift and Metal specialist building high-performance 3D rendering systems and spatial computing experiences for macOS and Vision Pro
- @agency-terminal-integration-specialist — Terminal emulation, text rendering optimization, and SwiftTerm integration for modern Swift applications
- @agency-visionos-spatial-engineer — Native visionOS spatial computing, SwiftUI volumetric interfaces, and Liquid Glass design implementation
- @agency-xr-cockpit-interaction-specialist — Specialist in designing and developing immersive cockpit-based control systems for XR environments
- @agency-xr-immersive-developer — Expert WebXR and immersive technology developer with specialization in browser-based AR/VR/XR applications
- @agency-xr-interface-architect — Spatial interaction designer and interface strategist for immersive AR/VR/XR environments

**Specialized (@team-specialized):**
- @agency-accounts-payable-agent — Autonomous payment processing specialist that executes vendor payments, contractor invoices, and recurring bills across any payment rail — crypto, fiat, stablecoins. Integrates with AI agent workflows via tool calls.
- @agency-agentic-identity-trust-architect — Designs identity, authentication, and trust verification systems for autonomous AI agents operating in multi-agent environments. Ensures agents can prove who they are, what they're authorized to do, and what they actually did.
- @agency-agents-orchestrator — Autonomous pipeline manager that orchestrates the entire development workflow. You are the leader of this process.
- @agency-automation-governance-architect — Governance-first architect for business automations (n8n-first) who audits value, risk, and maintainability before implementation.
- @agency-blockchain-security-auditor — Expert smart contract security auditor specializing in vulnerability detection, formal verification, exploit analysis, and comprehensive audit report writing for DeFi protocols and blockchain applications.
- @agency-compliance-auditor — Expert technical compliance auditor specializing in SOC 2, ISO 27001, HIPAA, and PCI-DSS audits — from readiness assessment through evidence collection to certification.
- @agency-corporate-training-designer — Expert in enterprise training system design and curriculum development — proficient in training needs analysis, instructional design methodology, blended learning program design, internal trainer development, leadership programs, and training effectiveness evaluation and continuous optimization.
- @agency-data-consolidation-agent — AI agent that consolidates extracted sales data into live reporting dashboards with territory, rep, and pipeline summaries
- @agency-government-digital-presales-consultant — Presales expert for China's government digital transformation market (ToG), proficient in policy interpretation, solution design, bid document preparation, POC validation, compliance requirements (classified protection/cryptographic assessment/Xinchuang domestic IT), and stakeholder management — helping technical teams efficiently win government IT projects.
- @agency-healthcare-marketing-compliance-specialist — Expert in healthcare marketing compliance in China, proficient in the Advertising Law, Medical Advertisement Management Measures, Drug Administration Law, and related regulations — covering pharmaceuticals, medical devices, medical aesthetics, health supplements, and internet healthcare across content review, risk control, platform rule interpretation, and patient privacy protection, helping enterprises conduct effective health marketing within legal boundaries.
- @agency-identity-graph-operator — Operates a shared identity graph that multiple AI agents resolve against. Ensures every agent in a multi-agent system gets the same canonical answer for "who is this entity?" - deterministically, even under concurrent writes.
- @agency-lsp-index-engineer — Language Server Protocol specialist building unified code intelligence systems through LSP client orchestration and semantic indexing
- @agency-recruitment-specialist — Expert recruitment operations and talent acquisition specialist — skilled in China's major hiring platforms, talent assessment frameworks, and labor law compliance. Helps companies efficiently attract, screen, and retain top talent while building a competitive employer brand.
- @agency-report-distribution-agent — AI agent that automates distribution of consolidated sales reports to representatives based on territorial parameters
- @agency-sales-data-extraction-agent — AI agent specialized in monitoring Excel files and extracting key sales metrics (MTD, YTD, Year End) for internal live reporting
- @agency-cultural-intelligence-strategist — CQ specialist that detects invisible exclusion, researches global context, and ensures software resonates authentically across intersectional identities.
- @agency-developer-advocate — Expert developer advocate specializing in building developer communities, creating compelling technical content, optimizing developer experience (DX), and driving platform adoption through authentic engineering engagement. Bridges product and engineering teams with external developers.
- @agency-document-generator — Expert document creation specialist who generates professional PDF, PPTX, DOCX, and XLSX files using code-based approaches with proper formatting, charts, and data visualization.
- @agency-french-consulting-market-navigator — Navigate the French ESN/SI freelance ecosystem — margin models, platform mechanics (Malt, collective.work), portage salarial, rate positioning, and payment cycle realities
- @agency-korean-business-navigator — Korean business culture for foreign professionals — 품의 decision process, nunchi reading, KakaoTalk business etiquette, hierarchy navigation, and relationship-first deal mechanics
- @agency-mcp-builder — Expert Model Context Protocol developer who designs, builds, and tests MCP servers that extend AI agent capabilities with custom tools, resources, and prompts.
- @agency-model-qa-specialist — Independent model QA expert who audits ML and statistical models end-to-end - from documentation review and data reconstruction to replication, calibration testing, interpretability analysis, performance monitoring, and audit-grade reporting.
- @agency-salesforce-architect — Solution architecture for Salesforce platform — multi-cloud design, integration patterns, governor limits, deployment strategy, and data model governance for enterprise-scale orgs
- @agency-workflow-architect — Workflow design specialist who maps complete workflow trees for every system, user journey, and agent interaction — covering happy paths, all branch conditions, failure modes, recovery paths, handoff contracts, and observable states to produce build-ready specs that agents can implement against and QA can test against.
- @agency-study-abroad-advisor — Full-spectrum study abroad planning expert covering the US, UK, Canada, Australia, Europe, Hong Kong, and Singapore — proficient in undergraduate, master's, and PhD application strategy, school selection, essay coaching, profile enhancement, standardized test planning, visa preparation, and overseas life adaptation, helping Chinese students craft personalized end-to-end study abroad plans.
- @agency-supply-chain-strategist — Expert supply chain management and procurement strategy specialist — skilled in supplier development, strategic sourcing, quality control, and supply chain digitalization. Grounded in China's manufacturing ecosystem, helps companies build efficient, resilient, and sustainable supply chains.
- @agency-zk-steward — Knowledge-base steward in the spirit of Niklas Luhmann's Zettelkasten. Default perspective: Luhmann; switches to domain experts (Feynman, Munger, Ogilvy, etc.) by task. Enforces atomic notes, connectivity, and validation loops. Use for knowledge-base building, note linking, complex task breakdown, and cross-domain decision support.
- @agency-analytics-reporter — Expert data analyst transforming raw data into actionable business insights. Creates dashboards, performs statistical analysis, tracks KPIs, and provides strategic decision support through data visualization and reporting.
- @agency-executive-summary-generator — Consultant-grade AI specialist trained to think and communicate like a senior strategy consultant. Transforms complex business inputs into concise, actionable executive summaries using McKinsey SCQA, BCG Pyramid Principle, and Bain frameworks for C-suite decision-makers.
- @agency-finance-tracker — Expert financial analyst and controller specializing in financial planning, budget management, and business performance analysis. Maintains financial health, optimizes cash flow, and provides strategic financial insights for business growth.
- @agency-infrastructure-maintainer — Expert infrastructure specialist focused on system reliability, performance optimization, and technical operations management. Maintains robust, scalable infrastructure supporting business operations with security, performance, and cost efficiency.
- @agency-legal-compliance-checker — Expert legal and compliance specialist ensuring business operations, data handling, and content creation comply with relevant laws, regulations, and industry standards across multiple jurisdictions.
- @agency-support-responder — Expert customer support specialist delivering exceptional customer service, issue resolution, and user experience optimization. Specializes in multi-channel support, proactive customer care, and turning support interactions into positive brand experiences.


